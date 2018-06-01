ARG from

FROM $from

ENV BUNDLE_GEMFILE=/gem/Gemfile

WORKDIR /gem

CMD ["sh", "-xc", "bin/setup && bundle exec appraisal install && bundle exec appraisal rake test"]

COPY . .
