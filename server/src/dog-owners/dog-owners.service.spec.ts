import { Test, TestingModule } from '@nestjs/testing';
import { DogOwnersService } from './dog-owners.service';

describe('DogOwnersService', () => {
  let service: DogOwnersService;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [DogOwnersService],
    }).compile();

    service = module.get<DogOwnersService>(DogOwnersService);
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });
});
