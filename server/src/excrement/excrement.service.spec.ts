import { Test, TestingModule } from '@nestjs/testing';
import { ExcrementService } from './excrement.service';

describe('ExcrementService', () => {
  let service: ExcrementService;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [ExcrementService],
    }).compile();

    service = module.get<ExcrementService>(ExcrementService);
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });
});
