import json
import logging

import boto3
import botocore

logging.getLogger().setLevel(logging.INFO)
log = logging.getLogger(__name__)

# Instantiate Boto3 clients & resources for every AWS service API called
s3_client = boto3.client("s3")
s3_resource = boto3.resource("s3")

# check if this tag already exists.
# Do it for tag deletion as well?
def tag_s3(bucket_name, resource_tags):
    new_tags = resource_tags
    try:
        response = s3_client.get_bucket_tagging(
            Bucket=bucket_name,
        )
        for tag_object in response["TagSet"]:
            new_tags.append(tag_object)
    except botocore.exceptions.ClientError as error:
        log.error(f"Boto3 API returned error: {error}")
        log.error(f"No Tags Received: {bucket_name}")
    try:
        response = s3_client.put_bucket_tagging(
            Bucket=bucket_name,
            Tagging={
                'TagSet': new_tags
            },
        )
    except botocore.exceptions.ClientError as error:
        log.error(f"Boto3 API returned error: {error}")
        log.error(f"No Tags Applied To: {bucket_name}")
        return False


def cloudtrail_event_parser(event):
    returned_event_fields = {}
    if event.get("detail").get("userIdentity").get("type") == "IAMUser":
        returned_event_fields["iam_user_name"] = (
            event.get("detail").get("userIdentity").get("userName", "")
        )
    if event.get("detail").get("eventName"):
        returned_event_fields["eventName"] = (
            event.get("detail").get("eventName", "")
        )
    if event.get("detail").get("requestParameters").get("bucketName"):
        returned_event_fields["bucketName"] = (
            event.get("detail").get("requestParameters").get("bucketName", "")
        )

    return returned_event_fields


def tag_resources(event, context):
    resource_tags = []

    event_fields = cloudtrail_event_parser(event)
    bucket_to_tag = event_fields.get("bucketName")
    event_name = event_fields.get("eventName")

    if event_fields.get("iam_user_name"):
        resource_tags.append(
            {"Key": "last_edited_by",
                "Value": event_fields["iam_user_name"]}
        )
    log.info(f"'eventName': {event_name}")
    if event_name == "CreateBucket" or event_name == "DeleteBucketTagging":
        tag_s3(bucket_to_tag, resource_tags)
        log.info("'statusCode': 200")
        log.info(f"'Bucket': {bucket_to_tag}")
        log.info(f"'body': {json.dumps(resource_tags)}")
    else:
        log.info("'statusCode': 500")
        log.info(f"'Bucket not created, Bucket': {bucket_to_tag}")
        log.info(f"'Lambda function name': {context.function_name}")
        log.info(f"'Lambda function version': {context.function_version}")