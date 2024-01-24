import { IsNotEmpty } from 'class-validator';

// model Diary {
//     id            String      @id @default(uuid())
//     title         String      @db.VarChar(100)
//     description   String      @db.VarChar(1000)
//     createdAt     DateTime    @default(now())
//     updatedAt     DateTime    @updatedAt
//     unregisterdAt DateTime?
//     dogId         String      @unique
//     dog           Dog         @relation(fields: [dogId], references: [id])
//     entries       WalkEntry[]
//   }

export class CreateDiaryDto {
  @IsNotEmpty()
  title: string;

  description: string;

  unregisterdAt?: string;

  dogId: string;
}
