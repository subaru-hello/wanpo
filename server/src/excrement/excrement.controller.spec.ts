import { Test, TestingModule } from '@nestjs/testing';
import { ExcrementController } from './excrement.controller';

describe('ExcrementController', () => {
  let controller: ExcrementController;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [ExcrementController],
    }).compile();

    controller = module.get<ExcrementController>(ExcrementController);
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });
});
