# Portal Predictions
[![Build Status](https://travis-ci.org/weecology/portalPredictions.svg?branch=master)](https://travis-ci.org/weecology/portalPredictions)
[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.833438.svg)](https://doi.org/10.5281/zenodo.833438)
[![License](http://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/weecology/portalPredictions/master/LICENSE)

#### [Portal Forecasting Website](http://portal.naturecast.org/)

This is the main repository for predictions made on the Portal rodent census data [Portal Project](http://portal.weecology.org/).

Predictions are made and archived weekly. Approximately once a month, one of these forecasts is made immediately prior to a new trapping session (trapping occurs as close to each new moon as possible).

## How to add a new model

Modeling is driven by the [portalcasting package](https://github.com/weecology/portalcasting). New models should be added there (see the see the ["adding a model"
vignette](https://weecology.github.io/portalcasting/articles/adding_a_model.html)).

## Docker builds

Forecasts are run using Travis CI based on a docker image. This makes the builds
faster and more reproducible. The image is built using `portalcasting` 
[v0.8.0](https://github.com/weecology/portalcasting/releases/tag/v0.8.0).

Adding new packages to this repo or updating existing packages will require 
rebuilding of the Docker container. When building, tag the image with 
the `latest` tag, as well as a named tag for the date (yyyy-mm-dd, which you should
replace with the actual current date). Use the following commands:

```
sudo docker build -t weecology/portal_predictions:latest -t weecology/portal_predictions:yyyy-mm-dd . 
sudo docker push weecology/portal_predictions
```

(Note that Windows users will not need to include the `sudo` command.)

