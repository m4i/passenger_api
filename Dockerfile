FROM ruby

WORKDIR /app

RUN set -eux; \
	gem install passenger_api; \
	passenger-config install-standalone-runtime; \
	passenger-config build-native-support




FROM ruby:slim

CMD ["passenger_api"]
EXPOSE 3000
WORKDIR /app

ENV \
	PASSENGER_APP_ENV=production \
	PASSENGER_MAX_POOL_SIZE=1 \
	PASSENGER_DISABLE_SECURITY_UPDATE_CHECK=true \
	PASSENGER_LOG_FILE=/dev/stdout

COPY --from=0 /usr/local/bundle /usr/local/bundle
