#!/bin/bash

# Concourse CI/CD Setup Script
# This script helps you set up Concourse pipelines for your Java project

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}========================================${NC}"
echo -e "${BLUE}    Concourse CI/CD Setup Script${NC}"
echo -e "${BLUE}========================================${NC}"

# Check if fly CLI is installed
if ! command -v fly &> /dev/null; then
    echo -e "${RED}Error: fly CLI is not installed!${NC}"
    echo -e "${YELLOW}Please install fly CLI first:${NC}"
    echo -e "  macOS: brew install concourse/fly/fly"
    echo -e "  Linux: Download from https://github.com/concourse/concourse/releases"
    exit 1
fi

echo -e "${GREEN}✓ fly CLI is installed${NC}"

# Get Concourse server URL
read -p "Enter your Concourse server URL (e.g., https://ci.your-domain.com): " CONCOURSE_URL

if [ -z "$CONCOURSE_URL" ]; then
    echo -e "${RED}Error: Concourse URL is required!${NC}"
    exit 1
fi

# Get team name
read -p "Enter your Concourse team name (default: main): " TEAM_NAME
TEAM_NAME=${TEAM_NAME:-main}

echo -e "${YELLOW}Setting up Concourse target...${NC}"

# Login to Concourse
fly --target my-ci login --team-name "$TEAM_NAME" -c "$CONCOURSE_URL"

echo -e "${GREEN}✓ Successfully logged in to Concourse${NC}"

# Check if vars file exists
if [ ! -f "concourse-vars.yml" ]; then
    echo -e "${RED}Error: concourse-vars.yml not found!${NC}"
    echo -e "${YELLOW}Please create and configure concourse-vars.yml first${NC}"
    exit 1
fi

echo -e "${GREEN}✓ Found concourse-vars.yml${NC}"

# Set up pipelines
echo -e "${YELLOW}Setting up pipelines...${NC}"

# Development Pipeline
echo -e "${BLUE}Setting up Development pipeline...${NC}"
fly -t my-ci set-pipeline \
    --config pipeline.yml \
    --pipeline dev-pipeline \
    --load-vars-from concourse-vars.yml \
    --var "environment=dev"

# Staging Pipeline
echo -e "${BLUE}Setting up Staging pipeline...${NC}"
fly -t my-ci set-pipeline \
    --config pipeline.yml \
    --pipeline staging-pipeline \
    --load-vars-from concourse-vars.yml \
    --var "environment=staging"

# Production Pipeline
echo -e "${BLUE}Setting up Production pipeline...${NC}"
fly -t my-ci set-pipeline \
    --config pipeline.yml \
    --pipeline prod-pipeline \
    --load-vars-from concourse-vars.yml \
    --var "environment=prod"

echo -e "${GREEN}✓ All pipelines set up successfully!${NC}"

# Unpause pipelines
echo -e "${YELLOW}Unpausing pipelines...${NC}"
fly -t my-ci unpause-pipeline --pipeline dev-pipeline
fly -t my-ci unpause-pipeline --pipeline staging-pipeline
fly -t my-ci unpause-pipeline --pipeline prod-pipeline

echo -e "${GREEN}✓ All pipelines are now active!${NC}"

# Display pipeline status
echo -e "${BLUE}========================================${NC}"
echo -e "${BLUE}    Pipeline Status${NC}"
echo -e "${BLUE}========================================${NC}"
fly -t my-ci pipelines

echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}    Setup Complete!${NC}"
echo -e "${GREEN}========================================${NC}"
echo -e "${YELLOW}Next steps:${NC}"
echo -e "1. Configure your SonarQube server and update concourse-vars.yml"
echo -e "2. Set up your deployment servers and SSH keys"
echo -e "3. Push code to trigger the pipelines"
echo -e "4. Monitor pipeline execution at: $CONCOURSE_URL"
echo -e ""
echo -e "${YELLOW}Useful commands:${NC}"
echo -e "  View pipelines: fly -t my-ci pipelines"
echo -e "  Trigger build: fly -t my-ci trigger-job --job dev-pipeline/dev-compile"
echo -e "  Watch build: fly -t my-ci watch --job dev-pipeline/dev-compile"
echo -e "  View logs: fly -t my-ci logs --job dev-pipeline/dev-compile"
