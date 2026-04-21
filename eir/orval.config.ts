import { defineConfig } from 'orval';

export default defineConfig({
  myService: {
    input: 'http://localhost:5001/swagger/v1/swagger.json',
    output: {
      target: './src/api/heimdell.ts',
      schemas: './src/api/model',
      client: 'react-query',
    },
  },
});