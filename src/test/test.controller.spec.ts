import { Test, TestingModule } from '@nestjs/testing';
import { TestController } from './test.controller';
import { INestApplication } from '@nestjs/common';
import * as request from 'supertest';

describe('TestController (e2e)', () => {
  let app: INestApplication;

  beforeAll(async () => {
    const moduleFixture: TestingModule = await Test.createTestingModule({
      controllers: [TestController],
    }).compile();

    app = moduleFixture.createNestApplication();
    await app.init();
  });

  it('/test (GET) doit retourner un JSON statique', async () => {
    const response = await request(app.getHttpServer()).get('/test');

    expect(response.status).toBe(200);
    expect(response.body).toHaveProperty('message', 'API de test OK');
    expect(response.body).toHaveProperty('date');
    expect(response.body).toHaveProperty('version', '1.0.0');
  });

  afterAll(async () => {
    await app.close();
  });
});
