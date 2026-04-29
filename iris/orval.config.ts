import { defineConfig } from 'orval';

export default defineConfig({
  janus: {
    input: 'http://localhost:5093/swagger/v1/swagger.json',
    output: {
      target: './src/api/janus.ts',
      schemas: './src/api/model',
      client: 'react-query',
      baseUrl: 'http://localhost:5093',
      override: {
        mutator: {
          path: './src/api/customFetch.ts',
          name: 'customFetch',
        },
      },
    },
  },
});