# FROM rocker/tidyverse:latest

# ENV TMPDIR=/tmp
# ENV TEMP=/tmp
# ENV TMP=/tmp
# ENV R_LIBS_USER=/usr/local/lib/R/site-library
# RUN chmod 777 /tmp

# RUN install2.r --error \
#     --deps TRUE \
#     renv

# COPY src ./opt/src

# COPY ./entry_point.sh /opt/
# RUN chmod +x /opt/entry_point.sh

# COPY ./requirements.txt /opt/
# COPY /packages /usr/local/lib/R/site-library



# WORKDIR /opt/src
# RUN chown -R 1000:1000 /opt/src
# RUN chmod 777 /opt/src

# ENV TMPDIR /tmp


# RUN R -e "devtools::install_version('glmnet', version = '4.1-8')"
# # RUN R -e "devtools::install_github('https://github.com/mlr-org/mlr3extralearners', force=TRUE)"
# # RUN R -e "devtools::install_github('https://github.com/a-hanf/mlr3automl', dependencies = TRUE, force=TRUE)"
# # RUN R -e "devtools::install_version('jsonlite', version='1.8.7', repos='https://cloud.r-project.org/')"
# RUN R -e "install.packages(c('mlr3', 'mlr3tuning', 'mlr3hyperband', 'mlr3pipelines', 'mlr3filters', 'mlr3misc', 'mlr3oml', 'mlr3learners', 'mlr3extralearners', 'checkmate', 'data.table', 'future', 'lgr', 'paradox', 'xgboost', 'LiblineaR', 'ranger', 'testthat', 'mlbench', 'randomForest', 'e1071', 'class', 'glmnet', 'kknn', 'MASS', 'rpart', 'rpart.plot', 'C50', 'liquidSVM', 'nnet'))"
# # RUN R -e "devtools::install_local('../packages/mlr3automl-master.zip')"
# # RUN R -e "devtools::install_local('../packages/mlr3extralearners-main.zip')"

# # RUN unzip ../packages/mlr3automl-master.zip -d ../packages/
# # RUN R -e "devtools::install('../packages/mlr3automl-master/')"



# USER 1000

# ENTRYPOINT ["/opt/entry_point.sh"]
# ENTRYPOINT [ "/bin/bash" ]

FROM rocker/tidyverse:latest

RUN install2.r --error \
    --deps TRUE \
    renv

COPY src ./opt/src

COPY ./entry_point.sh /opt/
RUN chmod +x /opt/entry_point.sh

COPY ./requirements.txt /opt/
COPY /packages /usr/local/lib/R/site-library

RUN mkdir -p /opt/tmp && chmod 1777 /opt/tmp
ENV TMPDIR /opt/tmp
ENV TEMP /opt/tmp
ENV TMP /opt/tmp

WORKDIR /opt/src
# RUN chown -R 1000:1000 /opt/src
# RUN chmod 777 /opt/

ENV R_LIBS_USER=/usr/local/lib/R/site-library


RUN R -e "devtools::install_version('glmnet', version = '4.1-8')"
RUN R -e "devtools::install_version('jsonlite', version='1.8.7', repos='https://cloud.r-project.org/')"
RUN R -e "install.packages(c('mlr3', 'mlr3tuning', 'mlr3hyperband', 'mlr3pipelines', 'mlr3filters', 'mlr3misc', 'mlr3oml', 'mlr3learners', 'mlr3extralearners', 'checkmate', 'data.table', 'future', 'lgr', 'paradox', 'xgboost', 'LiblineaR', 'ranger', 'testthat', 'mlbench', 'randomForest', 'e1071', 'class', 'glmnet', 'kknn', 'MASS', 'rpart', 'rpart.plot', 'C50', 'liquidSVM', 'nnet'))"

# RUN chown -R 1000:1000 /opt
# RUN chown -R 1000:1000 /tmp

USER 1000

ENTRYPOINT ["/opt/entry_point.sh"]
# ENTRYPOINT [ "/bin/bash" ]
