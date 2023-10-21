FROM rocker/tidyverse:latest

RUN install2.r --error \
    --deps TRUE \
    renv

COPY src ./opt/src

COPY ./entry_point.sh /opt/
RUN chmod +x /opt/entry_point.sh

COPY ./requirements.txt /opt/


WORKDIR /opt/src
RUN chown -R 1000:1000 /opt/src
RUN chmod 777 /opt/

ENV TMPDIR /tmp

RUN R -e "devtools::install_version('glmnet', version = '4.1-8')"
RUN R -e "devtools::install_github('https://github.com/mlr-org/mlr3extralearners', force=TRUE)"
RUN R -e "devtools::install_github('https://github.com/a-hanf/mlr3automl', dependencies = TRUE, force=TRUE)"
RUN R -e "devtools::install_version('jsonlite', version='1.8.7', repos='https://cloud.r-project.org/')"

USER 1000

ENTRYPOINT ["/opt/entry_point.sh"]
