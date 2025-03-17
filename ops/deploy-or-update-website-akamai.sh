#!/bin/bash 

if [ -z "${CLOUD_TAMER}" ] || [ -z "${AWS_ACCOUNT_NUMBER}" ]; then
  echo "ERROR: All parameters must be set."
  exit 1
fi

#
# Set conditional variables
#

# Set whether CloudTamer API should be used

if [ "${CLOUD_TAMER}" != "false" ] && [ "${CLOUD_TAMER}" != "true" ]; then
  echo "ERROR: CLOUD_TAMER parameter must be true or false"
  exit 1
elif [ "${CLOUD_TAMER}" = "false" ]; then

  # Turn off verbose logging for Jenkins jobs
  set +x
  echo "Don't print commands and their arguments as they are executed."
  CLOUD_TAMER="${CLOUD_TAMER}"

  # Import the "get temporary AWS credentials via AWS STS assume role" function
  source "./functions/fn_get_temporary_aws_credentials_via_aws_sts_assume_role.sh"

else # [ "${CLOUD_TAMER}" = "true" ]

  # Turn on verbose logging for development machine testing
  set -x
  echo "Print commands and their arguments as they are executed."
  CLOUD_TAMER="${CLOUD_TAMER}"

  # Import the "get temporary AWS credentials via CloudTamer API" function
  source "./functions/fn_get_temporary_aws_credentials_via_cloudtamer_api.sh"

fi

#
# Set AWS target environment
#

if [ "${CLOUD_TAMER}" = "true" ]; then
  fn_get_temporary_aws_credentials_via_cloudtamer_api "${AWS_ACCOUNT_NUMBER}" "${PARENT_ENV}"
else
  fn_get_temporary_aws_credentials_via_aws_sts_assume_role "${AWS_ACCOUNT_NUMBER}" "${PARENT_ENV}"
fi


# build website
bundle install

bundle exec jekyll build
