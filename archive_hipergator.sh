# Archive forecasts by pushing weekly forecasts to GitHub and tagging a
# release so that the GitHub-Zenodo integration archives the forecasts to
# Zenodo

# Only releases on cron driven events so that only weekly forecasts and not
# simple changes to the codebase triggers archiving.

current_date=`date -I | head -c 10`

# Setup on weecologydeploy user
git config --global user.email "weecologydeploy@weecology.org"
git config --global user.name "Weecology Deploy Bot"

# Commit changes to portalPredictions repo
git checkout main
git add data/* models/* casts/*
git commit -m "Update forecasts: HiperGator Build $current_date [ci skip]"

# Add deploy remote
# Needed to grant permissions through the deploy token
git remote remove deploy # Removing the remote ensures that updates to the GitHub Token are added to the remote
git remote add deploy https://${GITHUB_TOKEN}@github.com/weecology/portalPredictions.git

# Create a new portalPredictions tag for release
git tag $current_date

# If this is a cron event deploy, otherwise just check if we can

# Push updates to upstream
git push --quiet deploy main

# Create a new portalPredictions release to trigger Zenodo archiving
git push --quiet deploy --tags
curl -v -i -X POST -H "Content-Type:application/json" -H "Authorization: token $GITHUB_RELEASE_TOKEN" https://api.github.com/repos/weecology/portalPredictions/releases -d "{\"tag_name\":\"$current_date\"}"


# Clone forecasts archive repo
cd ../
git clone https://github.com/weecology/forecasts
cp portalPredictions/casts/*.* forecasts/portal/
cp portalPredictions/fits/*.* forecasts/portal/
cd forecasts

# Commit to forecasts repo
git add .
git commit -m "Update Portal forecasts: Build $current_date"
git remote remove deploy # Removing the remote ensures that updates to the GitHub Token are added to the remote
git remote add deploy https://${GITHUB_TOKEN}@github.com/weecology/forecasts.git

# Create a new forecasts tag
git tag $current_date

# Push updates to forecasts archive repo
git push --quiet deploy main

# Create a new forecasts release to trigger Zenodo archiving
git push --quiet deploy --tags
curl -v -i -X POST -H "Content-Type:application/json" -H "Authorization: token $GITHUB_TOKEN" https://api.github.com/repos/weecology/forecasts/releases -d "{\"tag_name\":\"$current_date\"}"
