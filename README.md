# 概要
CloudFrontからシンプルなHTMLを配信するコンポーネント。
以下のコンポーネントから構成。

    - cloudfront-s3origin
    - certificate
    - bucket_with_logging
    - bucket_policy_origin_access_identity

## cloudfront-s3origin
S3をバックにしたCloudFront。

## certificate
ACMから発行する証明書

## bucket_with_logging
ロギングを有効化したS3バケット

## bucket_policy_origin_access_identity
Origin Access Identity向けのS3バケットポリシー


