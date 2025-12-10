Learnigns:
  1. Git ignore file for current dir:
    ./*
    .*
    !/tf-pre-config/**/*
    !/main.tf
    !/remote.hcl
    !/variables_file.tfvars
  2. Git ignore file in sub dirs:
    *
    !main.tf
