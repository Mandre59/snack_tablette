import { Controller, Get } from '@nestjs/common';

@Controller('test')
export class TestController {
  @Get()
  getTest() {
    const testData = {
      message: 'API de test OK',
      date: new Date(),
      version: '1.0.0',
    };

    console.log('GET /test appelé :', testData);
    return testData;
  }
}
