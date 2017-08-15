ARG from

FROM $from

WORKDIR /gem

CMD ["sh", "-xc", "bin/setup && appraisal install && appraisal rake test"]

COPY . .
