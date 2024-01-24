import { Test, TestingModule } from '@nestjs/testing';
import { WalkEntryService } from './walk-entry.service';

describe('WalkEntryService', () => {
  let service: WalkEntryService;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [WalkEntryService],
    }).compile();

    service = module.get<WalkEntryService>(WalkEntryService);
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });
});
