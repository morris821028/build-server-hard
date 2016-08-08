#!/bin/bash

rsync -av /home/judgesister/JudgeNode/public/images morris821028@140.112.31.166::JudgeGirl/JudgeNode/images
rsync -av testdata morris821028@140.112.31.166::JudgeGirl/testdata
rsync -av source morris821028@140.112.31.166::JudgeGirl/source
rsync -av submission morris821028@140.112.31.166::JudgeGirl/submission
rsync -av DBs morris821028@140.112.31.166::JudgeGirl/DBs
