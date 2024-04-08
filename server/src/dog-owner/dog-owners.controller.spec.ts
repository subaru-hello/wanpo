import { Test, TestingModule } from '@nestjs/testing';
import { DogOwnersController } from './dog-owners.controller';

describe('DogOwnersController', () => {
  let controller: DogOwnersController;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [DogOwnersController],
    }).compile();

    controller = module.get<DogOwnersController>(DogOwnersController);
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });
});
