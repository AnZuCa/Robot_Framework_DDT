*** Settings ***
Documentation       General settings for libraries, and variable files in use

Library    Collections
Library    RequestsLibrary
Library    String
Variables  urls.yaml
Variables  Env_Data${/}${EXECUTION_ENV}.yaml

*** Variables ***
${EXECUTION_ENV}                    QA    # dev, qa, stage, uat, prod