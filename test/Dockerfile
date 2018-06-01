ARG from

FROM $from

ENV BUNDLE_GEMFILE=/gem/Gemfile

WORKDIR /gem

CMD ["sh", "-xc", "bin/setup && appraisal install && appraisal rake test"]

COPY . .
