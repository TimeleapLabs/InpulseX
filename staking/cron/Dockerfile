FROM public.ecr.aws/lambda/nodejs:20

COPY package.json package-lock.json index.js /var/task/
COPY lib/ /var/task/lib/

RUN npm install

CMD [ "index.handler" ]  
