/*
  Warnings:

  - The primary key for the `User` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `ban` on the `User` table. All the data in the column will be lost.
  - You are about to drop the column `citizenship` on the `User` table. All the data in the column will be lost.
  - You are about to drop the column `color` on the `User` table. All the data in the column will be lost.
  - You are about to drop the column `createdAt` on the `User` table. All the data in the column will be lost.
  - You are about to drop the column `isEmailVerified` on the `User` table. All the data in the column will be lost.
  - You are about to drop the column `isTerrorist` on the `User` table. All the data in the column will be lost.
  - You are about to drop the column `note` on the `User` table. All the data in the column will be lost.
  - You are about to drop the column `phoneNumber` on the `User` table. All the data in the column will be lost.
  - You are about to drop the column `resident` on the `User` table. All the data in the column will be lost.
  - You are about to drop the column `riskLevel` on the `User` table. All the data in the column will be lost.
  - You are about to drop the column `terroristFio` on the `User` table. All the data in the column will be lost.
  - You are about to drop the column `updatedAt` on the `User` table. All the data in the column will be lost.
  - You are about to drop the column `xcoJson` on the `User` table. All the data in the column will be lost.
  - You are about to drop the column `xcoid` on the `User` table. All the data in the column will be lost.
  - You are about to drop the `Account` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Admin` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `BettingMachine` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `BonusOperation` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `ClubCard` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Code` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Collation` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Collector` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `CollectorPPS` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Document` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Erai` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `EraiReport` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `FreeBet` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `FreeBetAccount` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `FreeBetDescription` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `FreeBetName` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `FreeBetTerms` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `FreeBetUserTerms` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `MessageFile` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Operation` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `OwnerPPS` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `PPS` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `PPSShift` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `PPSShiftLink` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Pari` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `PdlCategory` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `PdlRelative` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `PromoCode` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `PromoCodeAccount` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `RateNDFL` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Setting` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Ticket` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `TicketMessages` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Token` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Transaction` table. If the table is not empty, all the data it contains will be lost.
  - Added the required column `password` to the `User` table without a default value. This is not possible if the table is not empty.
  - Added the required column `salt` to the `User` table without a default value. This is not possible if the table is not empty.
  - Made the column `email` on table `User` required. This step will fail if there are existing NULL values in that column.

*/
-- DropForeignKey
ALTER TABLE "Account" DROP CONSTRAINT "Account_userId_fkey";

-- DropForeignKey
ALTER TABLE "Admin" DROP CONSTRAINT "Admin_ownerId_fkey";

-- DropForeignKey
ALTER TABLE "Admin" DROP CONSTRAINT "Admin_ppsId_fkey";

-- DropForeignKey
ALTER TABLE "BettingMachine" DROP CONSTRAINT "BettingMachine_accountId_fkey";

-- DropForeignKey
ALTER TABLE "BettingMachine" DROP CONSTRAINT "BettingMachine_ppsId_fkey";

-- DropForeignKey
ALTER TABLE "BonusOperation" DROP CONSTRAINT "BonusOperation_accountId_fkey";

-- DropForeignKey
ALTER TABLE "ClubCard" DROP CONSTRAINT "ClubCard_userId_fkey";

-- DropForeignKey
ALTER TABLE "Code" DROP CONSTRAINT "Code_userId_fkey";

-- DropForeignKey
ALTER TABLE "Collation" DROP CONSTRAINT "Collation_cashierId_fkey";

-- DropForeignKey
ALTER TABLE "Collation" DROP CONSTRAINT "Collation_ppsId_fkey";

-- DropForeignKey
ALTER TABLE "CollectorPPS" DROP CONSTRAINT "CollectorPPS_collectorId_fkey";

-- DropForeignKey
ALTER TABLE "CollectorPPS" DROP CONSTRAINT "CollectorPPS_ppsId_fkey";

-- DropForeignKey
ALTER TABLE "Document" DROP CONSTRAINT "Document_userId_fkey";

-- DropForeignKey
ALTER TABLE "Erai" DROP CONSTRAINT "Erai_reportId_fkey";

-- DropForeignKey
ALTER TABLE "Erai" DROP CONSTRAINT "Erai_transactionId_fkey";

-- DropForeignKey
ALTER TABLE "FreeBetAccount" DROP CONSTRAINT "FreeBetAccount_accountId_fkey";

-- DropForeignKey
ALTER TABLE "FreeBetAccount" DROP CONSTRAINT "FreeBetAccount_freeBetId_fkey";

-- DropForeignKey
ALTER TABLE "FreeBetDescription" DROP CONSTRAINT "FreeBetDescription_freeBetId_fkey";

-- DropForeignKey
ALTER TABLE "FreeBetName" DROP CONSTRAINT "FreeBetName_freeBetId_fkey";

-- DropForeignKey
ALTER TABLE "FreeBetTerms" DROP CONSTRAINT "FreeBetTerms_freeBetId_fkey";

-- DropForeignKey
ALTER TABLE "FreeBetUserTerms" DROP CONSTRAINT "FreeBetUserTerms_freeBetAccountId_fkey";

-- DropForeignKey
ALTER TABLE "FreeBetUserTerms" DROP CONSTRAINT "FreeBetUserTerms_termId_fkey";

-- DropForeignKey
ALTER TABLE "MessageFile" DROP CONSTRAINT "MessageFile_messageId_fkey";

-- DropForeignKey
ALTER TABLE "Operation" DROP CONSTRAINT "Operation_cashierId_fkey";

-- DropForeignKey
ALTER TABLE "Operation" DROP CONSTRAINT "Operation_collectorId_fkey";

-- DropForeignKey
ALTER TABLE "Operation" DROP CONSTRAINT "Operation_ppsId_fkey";

-- DropForeignKey
ALTER TABLE "Operation" DROP CONSTRAINT "Operation_shiftId_fkey";

-- DropForeignKey
ALTER TABLE "Operation" DROP CONSTRAINT "Operation_transactionId_fkey";

-- DropForeignKey
ALTER TABLE "PPS" DROP CONSTRAINT "PPS_ownerId_fkey";

-- DropForeignKey
ALTER TABLE "PPSShift" DROP CONSTRAINT "PPSShift_cashierId_fkey";

-- DropForeignKey
ALTER TABLE "PPSShift" DROP CONSTRAINT "PPSShift_ppsId_fkey";

-- DropForeignKey
ALTER TABLE "PPSShiftLink" DROP CONSTRAINT "PPSShiftLink_ppsId_fkey";

-- DropForeignKey
ALTER TABLE "PPSShiftLink" DROP CONSTRAINT "PPSShiftLink_shiftId_fkey";

-- DropForeignKey
ALTER TABLE "Pari" DROP CONSTRAINT "Pari_bettingId_fkey";

-- DropForeignKey
ALTER TABLE "Pari" DROP CONSTRAINT "Pari_freeBetId_fkey";

-- DropForeignKey
ALTER TABLE "Pari" DROP CONSTRAINT "Pari_userId_fkey";

-- DropForeignKey
ALTER TABLE "PdlCategory" DROP CONSTRAINT "PdlCategory_userId_fkey";

-- DropForeignKey
ALTER TABLE "PdlRelative" DROP CONSTRAINT "PdlRelative_userId_fkey";

-- DropForeignKey
ALTER TABLE "PromoCode" DROP CONSTRAINT "PromoCode_freebetId_fkey";

-- DropForeignKey
ALTER TABLE "PromoCodeAccount" DROP CONSTRAINT "PromoCodeAccount_accountId_fkey";

-- DropForeignKey
ALTER TABLE "PromoCodeAccount" DROP CONSTRAINT "PromoCodeAccount_promocodeId_fkey";

-- DropForeignKey
ALTER TABLE "Setting" DROP CONSTRAINT "Setting_userId_fkey";

-- DropForeignKey
ALTER TABLE "Ticket" DROP CONSTRAINT "Ticket_pariId_fkey";

-- DropForeignKey
ALTER TABLE "Ticket" DROP CONSTRAINT "Ticket_supportId_fkey";

-- DropForeignKey
ALTER TABLE "Ticket" DROP CONSTRAINT "Ticket_transactionId_fkey";

-- DropForeignKey
ALTER TABLE "Ticket" DROP CONSTRAINT "Ticket_userId_fkey";

-- DropForeignKey
ALTER TABLE "TicketMessages" DROP CONSTRAINT "TicketMessages_supportId_fkey";

-- DropForeignKey
ALTER TABLE "TicketMessages" DROP CONSTRAINT "TicketMessages_ticketId_fkey";

-- DropForeignKey
ALTER TABLE "TicketMessages" DROP CONSTRAINT "TicketMessages_userId_fkey";

-- DropForeignKey
ALTER TABLE "Token" DROP CONSTRAINT "Token_accountId_fkey";

-- DropForeignKey
ALTER TABLE "Transaction" DROP CONSTRAINT "Transaction_freeBetId_fkey";

-- DropForeignKey
ALTER TABLE "Transaction" DROP CONSTRAINT "Transaction_ppsId_fkey";

-- DropForeignKey
ALTER TABLE "Transaction" DROP CONSTRAINT "Transaction_userId_fkey";

-- DropIndex
DROP INDEX "User_phoneNumber_key";

-- AlterTable
ALTER TABLE "User" DROP CONSTRAINT "User_pkey",
DROP COLUMN "ban",
DROP COLUMN "citizenship",
DROP COLUMN "color",
DROP COLUMN "createdAt",
DROP COLUMN "isEmailVerified",
DROP COLUMN "isTerrorist",
DROP COLUMN "note",
DROP COLUMN "phoneNumber",
DROP COLUMN "resident",
DROP COLUMN "riskLevel",
DROP COLUMN "terroristFio",
DROP COLUMN "updatedAt",
DROP COLUMN "xcoJson",
DROP COLUMN "xcoid",
ADD COLUMN     "password" TEXT NOT NULL,
ADD COLUMN     "salt" TEXT NOT NULL,
ALTER COLUMN "id" DROP DEFAULT,
ALTER COLUMN "id" SET DATA TYPE TEXT,
ALTER COLUMN "email" SET NOT NULL,
ADD CONSTRAINT "User_pkey" PRIMARY KEY ("id");
DROP SEQUENCE "User_id_seq";

-- DropTable
DROP TABLE "Account";

-- DropTable
DROP TABLE "Admin";

-- DropTable
DROP TABLE "BettingMachine";

-- DropTable
DROP TABLE "BonusOperation";

-- DropTable
DROP TABLE "ClubCard";

-- DropTable
DROP TABLE "Code";

-- DropTable
DROP TABLE "Collation";

-- DropTable
DROP TABLE "Collector";

-- DropTable
DROP TABLE "CollectorPPS";

-- DropTable
DROP TABLE "Document";

-- DropTable
DROP TABLE "Erai";

-- DropTable
DROP TABLE "EraiReport";

-- DropTable
DROP TABLE "FreeBet";

-- DropTable
DROP TABLE "FreeBetAccount";

-- DropTable
DROP TABLE "FreeBetDescription";

-- DropTable
DROP TABLE "FreeBetName";

-- DropTable
DROP TABLE "FreeBetTerms";

-- DropTable
DROP TABLE "FreeBetUserTerms";

-- DropTable
DROP TABLE "MessageFile";

-- DropTable
DROP TABLE "Operation";

-- DropTable
DROP TABLE "OwnerPPS";

-- DropTable
DROP TABLE "PPS";

-- DropTable
DROP TABLE "PPSShift";

-- DropTable
DROP TABLE "PPSShiftLink";

-- DropTable
DROP TABLE "Pari";

-- DropTable
DROP TABLE "PdlCategory";

-- DropTable
DROP TABLE "PdlRelative";

-- DropTable
DROP TABLE "PromoCode";

-- DropTable
DROP TABLE "PromoCodeAccount";

-- DropTable
DROP TABLE "RateNDFL";

-- DropTable
DROP TABLE "Setting";

-- DropTable
DROP TABLE "Ticket";

-- DropTable
DROP TABLE "TicketMessages";

-- DropTable
DROP TABLE "Token";

-- DropTable
DROP TABLE "Transaction";

-- DropEnum
DROP TYPE "AccountGender";

-- DropEnum
DROP TYPE "AccountLimit";

-- DropEnum
DROP TYPE "AccountType";

-- DropEnum
DROP TYPE "AdminRole";

-- DropEnum
DROP TYPE "CitizenshipCode";

-- DropEnum
DROP TYPE "CodeType";

-- DropEnum
DROP TYPE "CollationStatus";

-- DropEnum
DROP TYPE "DocumentStatus";

-- DropEnum
DROP TYPE "DocumentType";

-- DropEnum
DROP TYPE "EraiReportStatus";

-- DropEnum
DROP TYPE "EraiReportVerdict";

-- DropEnum
DROP TYPE "EraiStatus";

-- DropEnum
DROP TYPE "EraiType";

-- DropEnum
DROP TYPE "FreeBetBet";

-- DropEnum
DROP TYPE "FreeBetKindBet";

-- DropEnum
DROP TYPE "FreeBetPlaceBet";

-- DropEnum
DROP TYPE "FreeBetTermsType";

-- DropEnum
DROP TYPE "FreeBetType";

-- DropEnum
DROP TYPE "OperationMethod";

-- DropEnum
DROP TYPE "OperationType";

-- DropEnum
DROP TYPE "PariStatus";

-- DropEnum
DROP TYPE "PariType";

-- DropEnum
DROP TYPE "PdlCategoryNameEnum";

-- DropEnum
DROP TYPE "PdlCategoryTypeEnum";

-- DropEnum
DROP TYPE "PromoCodeType";

-- DropEnum
DROP TYPE "RateNDFLType";

-- DropEnum
DROP TYPE "ShiftState";

-- DropEnum
DROP TYPE "ShiftType";

-- DropEnum
DROP TYPE "TicketStatus";

-- DropEnum
DROP TYPE "TicketType";

-- DropEnum
DROP TYPE "TokenType";

-- DropEnum
DROP TYPE "TransactionConfirmation";

-- DropEnum
DROP TYPE "TransactionMethod";

-- DropEnum
DROP TYPE "TransactionRef";

-- DropEnum
DROP TYPE "TransactionStatus";

-- DropEnum
DROP TYPE "UserColor";

-- DropEnum
DROP TYPE "UserStatus";
