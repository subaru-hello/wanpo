import { Test, TestingModule } from '@nestjs/testing';
import { WalkEntryController } from './walk-entry.controller';

describe('WalkEntryController', () => {
  let controller: WalkEntryController;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [WalkEntryController],
    }).compile();

    controller = module.get<WalkEntryController>(WalkEntryController);
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });
});
