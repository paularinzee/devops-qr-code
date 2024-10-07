# FROM node:18-alpine AS base

# # Set working directly in the container
# WORKDIR /app

# # Copy the dependencies file to the working directly
# COPY package.json yarn.lock* package-lock.json* pnpm-lock.yaml* ./

# # Install any needed packages
# RUN \
#     if [ -f yarn.lock]; then yarn --frozen-lockfile; \
#     elif [ -f package-lock.json]; then npm ci; \
#     elif [ -f pnpm-lock.yaml ]; then corepack enable pnpm $$ pnpm i --frozen-lockfile; \
#     else echo "Lockfile not found." && exit 1; \
#     fi

# # copy the content of the local src directory to the working directory
# COPY . .

# # Run the app
# RUN npm run build

# EXPOSE 3000

# CMD [ "npm", "start" ]

FROM node:20 As base

WORKDIR /usr/src/app

COPY package.json package.json
RUN npm install

COPY . .

FROM base As developmet
EXPOSE 3000
CMD [ "npm" , "run"  , "dev"]


FROM base As production
EXPOSE 3000
RUN npm run build
CMD ["npm", "start"]