FROM python:3.9-alpine3.13

LABEL maintainer="imanuwardi.com"

# Perbaikan di baris ini: tambahkan tanda '='
ENV PYTHONUNBUFFERED=1

COPY ./requirements.txt /tmp/requirements.txt
COPY ./requirements.dev.txt /tmp/requirements.dev.txt
COPY ./app /app
WORKDIR /app
EXPOSE 8000

ARG DEV=false
RUN python -m venv /py && \
    /py/bin/pip install --upgrade pip && \
    /py/bin/pip install -r /tmp/requirements.txt && \
    if [ $DEV = "true" ]; \
        then /py/bin/pip install -r /tmp/requirements.dev.txt; \
    fi && \
    rm -rf /tmp && \
    adduser \
        --disabled-password \
        --no-create-home \
        django-user

# Gunakan format yang sama untuk PATH (sudah benar, tapi pastikan konsisten)
ENV PATH="/py/bin:$PATH"

USER django-user

