FROM rocker/tidyverse:latest

RUN install2.r --error \
    --deps TRUE \
    renv

COPY src ./opt/src

COPY ./entry_point.sh /opt/
RUN chmod +x /opt/entry_point.sh


# Install R packages with specific versions from requirements.txt
RUN R -e "devtools::install_github('https://github.com/a-hanf/mlr3automl', dependencies = TRUE)"
RUN R -e "devtools::install_github('https://github.com/mlr-org/mlr3extralearners')"
RUN R -e "devtools::install_version('jsonlite', version='1.8.7', repos='https://cloud.r-project.org/')"

COPY ./requirements.txt /opt/


WORKDIR /opt/src
RUN chown -R 1000:1000 /opt/src

ENV TMPDIR /opt/

USER 1000

ENTRYPOINT ["/opt/entry_point.sh"]
