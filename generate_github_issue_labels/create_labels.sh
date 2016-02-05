###
# Label definitions
###

declare -A LABELS

# Platform BABY BLUE
LABELS["ruby"]="BFD4F2"
LABELS["sql"]="BFD4F2"
LABELS["python"]="BFD4F2"
LABELS["groove"]="BFD4F2"
LABELS["c++"]="BFD4F2"
LABELS["node.js"]="BFD4F2"
LABELS["html"]="BFD4F2"
LABELS["bash/os"]="BFD4F2"

# Problems RED
LABELS["bug"]="EE3F46"
LABELS["blocker"]="EE3F46"

# Product Management LIGHT ORANGE
LABELS["product_mgmt"]="FFC274"

# Feature/Improvement GREEN
LABELS["feature"]="91CA55"
LABELS["improvement"]="91CA55"

# Inactive GRAY
LABELS["inactive"]="D2DAE1"

# Feedback PEACH
LABELS["user_feedback"]="FAD8C7"

# Environment PLUM
LABELS["development"]="CC317C"
LABELS["testing"]="CC317C"
LABELS["production"]="CC317C"

# Content LIGHT YELLOW
LABELS["content"]="FEF2C0"

# Design ELECTRIC ORANGE
LABELS["user_experience"]="FBCA04"


###
# Get a token from Github
###

TOKEN=$(cat .token)

read -p "Who owns the repo you want labels on?: " owner
read -p "What repo do you want labels on?: " repo

for K in "${!LABELS[@]}"; do
  CURL_OUTPUT=$(curl -s -H "Authorization: token $TOKEN" -X POST "https://api.github.com/repos/$owner/$repo/labels" -d "{\"name\":\"$K\", \"color\":\"${LABELS[$K]}\"}")
  HAS_ERROR=$(echo "$CURL_OUTPUT" | jq -r '.errors')

  if [ ! -z "$HAS_ERROR" ] && [ "$HAS_ERROR" != null ]; then
    ERROR=$(echo "$CURL_OUTPUT" | jq -r '.errors[0].code')

    if [ "$ERROR" == "already_exists" ]; then
      # We update
      echo "'$K' already exists. Updating..."
      CURL_OUTPUT=$(curl -s -H "Authorization: token $TOKEN" -X PATCH "https://api.github.com/repos/$owner/$repo/labels/${K/ /%20}" -d "{\"name\":\"$K\", \"color\":\"${LABELS[$K]}\"}")
    else
      echo "Unknown error: $ERROR"
      echo "Output from curl: "
      echo "$CURL_OUTPUT"
      echo "Exiting..."
      exit 1;
    fi
  else
    echo "Created '$K'."
  fi
done
exit 0
