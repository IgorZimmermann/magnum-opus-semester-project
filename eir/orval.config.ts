import { defineConfig } from 'orval';

export default defineConfig({
  heimdall: {
    input: 'http://localhost:5001/swagger/v1/swagger.json',
    output: {
      target: './src/api/heimdell.ts',
      schemas: './src/api/model',
      client: 'react-query',
      baseUrl: 'http://localhost:5001',
      override: {
        mutator: {
          path: './src/api/customFetch.ts',
          name: 'customFetch',
        },
      },
    },
  },
});