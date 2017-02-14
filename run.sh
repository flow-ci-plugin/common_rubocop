# ************************************************************
#
# This step will use ruby anlayzer Rubocop to check files
#
#   Variables used:
#
#   Outputs:
#     $FLOW_RUBOCOP_LOG_PATH
#     $FLOW_RUBOCOP_SUMMARY_OFFENSE_COUNT
#     $FLOW_RUBOCOP_SUMMARY_TARGET_FILE_COUNT
#     $FLOW_RUBOCOP_SUMMARY_INSPECTED_FILE_COUNT
#
# ************************************************************

set +e
cd $FLOW_CURRENT_PROJECT_PATH
gem install rubocop
if [[ -e ".rubocop.yml" ]]; then
  echo ".rubocop.yml found, loading..."
else
  echo ".rubocop.yml not found, using default file..."
  curl -sSL https://raw.githubusercontent.com/FIRHQ/code-quality-configs/master/rubocop.yml > .rubocop.yml
fi

#rubocop -c /tmp/rubocop.yml --format json $FLOW_RUBOCOP_CHECK_DIR
FLOW_RUBOCOP_LOG_PATH="${FLOW_WORKSPACE}/output/rubocop.json"
rubocop -c .rubocop.yml --format json > ${FLOW_WORKSPACE}/output/rubocop.json
FLOW_RUBOCOP_SUMMARY_OFFENSE_COUNT=$(jq '.summary.offense_count' $FLOW_RUBOCOP_LOG_PATH)
FLOW_RUBOCOP_SUMMARY_TARGET_FILE_COUNT=$(jq '.summary.target_file_count' $FLOW_RUBOCOP_LOG_PATH)
FLOW_RUBOCOP_SUMMARY_INSPECTED_FILE_COUNT=$(jq '.summary.inspected_file_count' $FLOW_RUBOCOP_LOG_PATH)
echo "offense_count $FLOW_RUBOCOP_SUMMARY_OFFENSE_COUNT"
echo "target_file_count $FLOW_RUBOCOP_SUMMARY_TARGET_FILE_COUNT"
echo "inspected_file_count $FLOW_RUBOCOP_SUMMARY_INSPECTED_FILE_COUNT"
