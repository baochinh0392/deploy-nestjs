FROM node:12-alpine3.12

# Information about author
LABEL author.name="care" \
  author.email="care@ofzoey.com"

# Set the timezone.
ENV TZ=Asia/Singapore
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

WORKDIR /app_nestjs

RUN apk update && apk upgrade && apk add --no-cache bash git openssh gcc g++

COPY ./dist ./dist/
COPY package.json ./
COPY yarn.lock ./
COPY tsconfig*.json ./
COPY ./node_modules ./node_modules/
COPY . .

RUN yarn install --only=production
EXPOSE 5000
CMD yarn start:prod
