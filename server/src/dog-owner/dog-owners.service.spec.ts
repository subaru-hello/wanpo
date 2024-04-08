import { Test, TestingModule } from '@nestjs/testing';
import { DogOwnerService } from './dog-owners.service';

describe('DogOwnerService', () => {
  let service: DogOwnerService;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [DogOwnerService],
    }).compile();

    service = module.get<DogOwnerService>(DogOwnerService);
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });
});
