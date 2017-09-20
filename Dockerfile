FROM gocd/gocd-agent-alpine-3.6:v17.10.0

RUN apk add --no-cache openjdk8 maven ruby ruby-irb ruby-rdoc && \
gem install bundler
