-- CreateEnum
CREATE TYPE "TokenType" AS ENUM ('mobile', 'desktop');

-- CreateEnum
CREATE TYPE "PdlCategoryTypeEnum" AS ENUM ('category', 'category407');

-- CreateEnum
CREATE TYPE "PdlCategoryNameEnum" AS ENUM ('civil_service', 'rpdl', 'mpdl', 'idpl', 'sanction', 'closest', 'closest_gov', 'closest_rpdl', 'closest_mpdl', 'closest_ipdl', 'closest_san', 'ex_civil_service', 'ex_rpdl', 'ex_mpdl', 'ex_idpl', 'ex_sanction', 'watch_list', 'ex_watch_list', 'closest_watch_list');

-- CreateEnum
CREATE TYPE "PromoCodeType" AS ENUM ('registration', 'other');

-- CreateEnum
CREATE TYPE "FreeBetType" AS ENUM ('bonus', 'freebet', 'personal', 'loyality', 'promocode');

-- CreateEnum
CREATE TYPE "FreeBetTermsType" AS ENUM ('deposit', 'bet', 'identification', 'registration', 'promocode');

-- CreateEnum
CREATE TYPE "FreeBetBet" AS ENUM ('express', 'resident');

-- CreateEnum
CREATE TYPE "FreeBetKindBet" AS ENUM ('live', 'prematch', 'game24');

-- CreateEnum
CREATE TYPE "FreeBetPlaceBet" AS ENUM ('site', 'pps', 'mobile');

-- CreateEnum
CREATE TYPE "OperationType" AS ENUM ('refill', 'withdrawal');

-- CreateEnum
CREATE TYPE "OperationMethod" AS ENUM ('user', 'encashment');

-- CreateEnum
CREATE TYPE "AdminRole" AS ENUM ('root', 'manager', 'managerSupport', 'managerPPS', 'adminPPS', 'cashier', 'accountant', 'accountant2', 'infoDepartment', 'infoDepartment1', 'infoDepartment2', 'infoDepartment3', 'support', 'marketolog', 'pdl');

-- CreateEnum
CREATE TYPE "UserStatus" AS ENUM ('noVerified', 'verified', 'starting', 'advanced', 'waiting');

-- CreateEnum
CREATE TYPE "CodeType" AS ENUM ('cupis', 'local');

-- CreateEnum
CREATE TYPE "TransactionStatus" AS ENUM ('success', 'wait', 'fail', 'rejected');

-- CreateEnum
CREATE TYPE "TransactionConfirmation" AS ENUM ('needConfirm', 'auto', 'confirmed');

-- CreateEnum
CREATE TYPE "TransactionRef" AS ENUM ('input', 'output');

-- CreateEnum
CREATE TYPE "DocumentType" AS ENUM ('rfPassport', 'exPassport', 'snils', 'inn');

-- CreateEnum
CREATE TYPE "DocumentStatus" AS ENUM ('success', 'wait', 'fail');

-- CreateEnum
CREATE TYPE "PariType" AS ENUM ('game24', 'sportbet');

-- CreateEnum
CREATE TYPE "PariStatus" AS ENUM ('inPlay', 'win', 'loss', 'cancelled', 'refund', 'sale');

-- CreateEnum
CREATE TYPE "UserColor" AS ENUM ('green', 'red', 'blue', 'yellow');

-- CreateEnum
CREATE TYPE "TicketStatus" AS ENUM ('draft', 'work', 'closed', 'answered', 'new');

-- CreateEnum
CREATE TYPE "TicketType" AS ENUM ('calculation', 'refill', 'withdrawal', 'support', 'website', 'identification', 'shares');

-- CreateEnum
CREATE TYPE "EraiType" AS ENUM ('deposits', 'depositsSum', 'payments', 'paymentsSum', 'bets', 'report', 'bettingSlips', 'bettingSlipsSum', 'ppsUpdate', 'ppsRemove', 'customers', 'customersDelete');

-- CreateEnum
CREATE TYPE "EraiStatus" AS ENUM ('wait', 'success', 'fail');

-- CreateEnum
CREATE TYPE "EraiReportStatus" AS ENUM ('wait', 'success', 'fail');

-- CreateEnum
CREATE TYPE "EraiReportVerdict" AS ENUM ('pending', 'checked', 'successful', 'unsuccessful');

-- CreateEnum
CREATE TYPE "RateNDFLType" AS ENUM ('bets', 'profit');

-- CreateEnum
CREATE TYPE "CitizenshipCode" AS ENUM ('RUS', 'NONE');

-- CreateEnum
CREATE TYPE "AccountType" AS ENUM ('pps', 'cupis');

-- CreateEnum
CREATE TYPE "AccountLimit" AS ENUM ('level1', 'level2', 'level3', 'level4', 'level5', 'level6', 'level7', 'level8');

-- CreateEnum
CREATE TYPE "ShiftType" AS ENUM ('checkout', 'surrender');

-- CreateEnum
CREATE TYPE "ShiftState" AS ENUM ('open', 'close', 'acceptanceReport', 'lessAmount', 'overAmount', 'canceled');

-- CreateEnum
CREATE TYPE "CollationStatus" AS ENUM ('norm', 'over', 'less');

-- CreateEnum
CREATE TYPE "AccountGender" AS ENUM ('man', 'women');

-- CreateEnum
CREATE TYPE "TransactionMethod" AS ENUM ('noCash', 'cash');

-- CreateTable
CREATE TABLE "Admin" (
    "id" SERIAL NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "role" "AdminRole" NOT NULL,
    "token" TEXT,
    "password" TEXT NOT NULL,
    "login" TEXT NOT NULL,
    "status" BOOLEAN DEFAULT false,
    "online" BOOLEAN DEFAULT false,
    "ppsId" INTEGER,
    "ownerId" INTEGER,
    "firstName" TEXT,
    "lastName" TEXT,
    "paternalName" TEXT,
    "birth" TIMESTAMP(3),
    "inn" TEXT,
    "series" TEXT,
    "number" TEXT,

    CONSTRAINT "Admin_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "User" (
    "id" SERIAL NOT NULL,
    "phoneNumber" TEXT NOT NULL,
    "email" TEXT,
    "isEmailVerified" BOOLEAN NOT NULL DEFAULT false,
    "ban" BOOLEAN NOT NULL DEFAULT false,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "color" "UserColor",
    "note" TEXT,
    "resident" BOOLEAN DEFAULT true,
    "citizenship" "CitizenshipCode" NOT NULL DEFAULT 'RUS',
    "riskLevel" INTEGER,
    "xcoid" TEXT,
    "xcoJson" JSONB,
    "isTerrorist" BOOLEAN,
    "terroristFio" TEXT,

    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Account" (
    "id" SERIAL NOT NULL,
    "userId" INTEGER NOT NULL,
    "token" TEXT NOT NULL,
    "balance" INTEGER NOT NULL DEFAULT 0,
    "bonusBalance" INTEGER NOT NULL DEFAULT 0,
    "bonusBalanceByAdmin" INTEGER NOT NULL DEFAULT 0,
    "blockedBalance" INTEGER NOT NULL DEFAULT 0,
    "password" TEXT,
    "saleModal" BOOLEAN DEFAULT true,
    "status" "UserStatus" NOT NULL,
    "psp" BOOLEAN NOT NULL DEFAULT false,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "type" "AccountType" NOT NULL DEFAULT 'pps',
    "blocked" BOOLEAN DEFAULT false,
    "firstName" TEXT,
    "lastName" TEXT,
    "paternalName" TEXT,
    "birth" TIMESTAMP(3),
    "birthLocation" TEXT,
    "address" TEXT,
    "citizenship" "CitizenshipCode",
    "online" TIMESTAMP(3),
    "limit" "AccountLimit" DEFAULT 'level1',
    "inn" TEXT,
    "gender" "AccountGender",
    "resident" BOOLEAN DEFAULT true,
    "fullName" TEXT,

    CONSTRAINT "Account_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Token" (
    "token" TEXT NOT NULL,
    "userAgent" TEXT NOT NULL,
    "accountId" INTEGER,
    "type" "TokenType" NOT NULL,
    "exp" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- CreateTable
CREATE TABLE "PdlCategory" (
    "id" SERIAL NOT NULL,
    "type" "PdlCategoryTypeEnum" NOT NULL,
    "code" TEXT NOT NULL,
    "name" "PdlCategoryNameEnum",
    "userId" INTEGER,

    CONSTRAINT "PdlCategory_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PdlRelative" (
    "id" SERIAL NOT NULL,
    "json" JSONB,
    "userId" INTEGER,

    CONSTRAINT "PdlRelative_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "BonusOperation" (
    "id" SERIAL NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "expiredAt" TIMESTAMP(3),
    "amount" INTEGER NOT NULL DEFAULT 0,
    "accountId" INTEGER,

    CONSTRAINT "BonusOperation_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Collation" (
    "id" TEXT NOT NULL,
    "cashierId" INTEGER,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "amount" INTEGER DEFAULT 0,
    "ppsId" INTEGER,
    "status" "CollationStatus" NOT NULL DEFAULT 'norm',
    "differenceAmount" DOUBLE PRECISION NOT NULL DEFAULT 0,

    CONSTRAINT "Collation_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Collector" (
    "id" TEXT NOT NULL,
    "login" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "firstName" TEXT,
    "lastName" TEXT,
    "paternalName" TEXT,
    "status" BOOLEAN NOT NULL DEFAULT false,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "token" TEXT NOT NULL,
    "series" TEXT,
    "number" TEXT,
    "issuer" TEXT DEFAULT '',
    "issuerDate" TIMESTAMP(3),
    "issuerCode" TEXT DEFAULT '',

    CONSTRAINT "Collector_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CollectorPPS" (
    "id" TEXT NOT NULL,
    "collectorId" TEXT NOT NULL,
    "ppsId" INTEGER NOT NULL,
    "status" BOOLEAN NOT NULL DEFAULT false,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "CollectorPPS_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Setting" (
    "userId" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "push" BOOLEAN NOT NULL DEFAULT true,
    "notifications" BOOLEAN NOT NULL DEFAULT true,
    "sms" BOOLEAN NOT NULL DEFAULT true,

    CONSTRAINT "Setting_pkey" PRIMARY KEY ("userId")
);

-- CreateTable
CREATE TABLE "Code" (
    "userId" INTEGER NOT NULL,
    "value" TEXT NOT NULL DEFAULT '',
    "time" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "type" "CodeType" NOT NULL DEFAULT 'local',
    "repeat" INTEGER NOT NULL DEFAULT 3,
    "last" TEXT,
    "ban" BOOLEAN NOT NULL DEFAULT false,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Code_pkey" PRIMARY KEY ("userId")
);

-- CreateTable
CREATE TABLE "Transaction" (
    "id" SERIAL NOT NULL,
    "userId" INTEGER,
    "amount" INTEGER NOT NULL,
    "method" "TransactionMethod",
    "status" "TransactionStatus" NOT NULL,
    "ref" "TransactionRef" NOT NULL,
    "token" TEXT,
    "requestId" TEXT,
    "fee" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "timestampProvider" TIMESTAMP(3),
    "channel" TEXT,
    "currency" TEXT,
    "createdAt" TIMESTAMPTZ(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMPTZ(3) NOT NULL,
    "confirmation" "TransactionConfirmation" DEFAULT 'auto',
    "ppsId" INTEGER,
    "freeBetId" INTEGER,
    "uuid" TEXT,
    "ndfl" DOUBLE PRECISION DEFAULT 0,
    "ndfl1c" DOUBLE PRECISION DEFAULT 0,
    "stavka" TEXT,
    "isBonus" BOOLEAN,

    CONSTRAINT "Transaction_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Erai" (
    "id" TEXT NOT NULL,
    "status" "EraiStatus" NOT NULL DEFAULT 'wait',
    "type" "EraiType" NOT NULL,
    "payload" TEXT,
    "quarter" TEXT,
    "result" TEXT,
    "transactionId" INTEGER,
    "reportId" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Erai_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "EraiReport" (
    "id" TEXT NOT NULL,
    "verdict" "EraiReportVerdict" NOT NULL DEFAULT 'pending',
    "type" "EraiType" NOT NULL,
    "fileId" TEXT,
    "comment" TEXT DEFAULT '',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,
    "date" TEXT,

    CONSTRAINT "EraiReport_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Document" (
    "id" TEXT NOT NULL,
    "type" "DocumentType" NOT NULL,
    "lastName" TEXT,
    "firstName" TEXT,
    "paternalName" TEXT,
    "birth" TIMESTAMP(3),
    "series" TEXT,
    "number" TEXT,
    "validTo" TEXT,
    "errorCode" TEXT,
    "processId" TEXT,
    "address" TEXT,
    "birthAddress" TEXT,
    "blocked" BOOLEAN NOT NULL DEFAULT false,
    "status" "DocumentStatus" NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "issueDate" TEXT DEFAULT '',
    "issuer" TEXT DEFAULT '',
    "issuerCode" TEXT DEFAULT '',
    "userId" INTEGER NOT NULL,
    "countryCode" TEXT DEFAULT '643',

    CONSTRAINT "Document_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Pari" (
    "id" TEXT NOT NULL,
    "userId" INTEGER,
    "hash" TEXT NOT NULL,
    "type" "PariType" NOT NULL,
    "isExpress" BOOLEAN DEFAULT false,
    "description" TEXT DEFAULT '',
    "status" "PariStatus" NOT NULL,
    "amount" INTEGER NOT NULL,
    "winAmount" INTEGER,
    "winHash" TEXT,
    "payload" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "bettingId" TEXT,
    "freeBetId" INTEGER,
    "useBonus" BOOLEAN DEFAULT false,
    "nards" JSONB[],

    CONSTRAINT "Pari_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Ticket" (
    "id" SERIAL NOT NULL,
    "status" "TicketStatus" NOT NULL,
    "type" "TicketType" NOT NULL,
    "isReaded" BOOLEAN NOT NULL DEFAULT false,
    "supportId" INTEGER,
    "pariId" TEXT,
    "transactionId" INTEGER,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "userId" INTEGER NOT NULL,

    CONSTRAINT "Ticket_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "TicketMessages" (
    "id" SERIAL NOT NULL,
    "text" TEXT NOT NULL,
    "ticketId" INTEGER NOT NULL,
    "supportId" INTEGER,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "userId" INTEGER,

    CONSTRAINT "TicketMessages_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "MessageFile" (
    "id" TEXT NOT NULL,
    "messageId" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "MessageFile_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "RateNDFL" (
    "id" SERIAL NOT NULL,
    "rate" DOUBLE PRECISION NOT NULL DEFAULT 13,
    "maxAmount" DOUBLE PRECISION NOT NULL DEFAULT 100000,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "type" "RateNDFLType" NOT NULL DEFAULT 'profit',
    "active" BOOLEAN NOT NULL DEFAULT false,
    "year" INTEGER NOT NULL DEFAULT 2024,
    "resident" BOOLEAN NOT NULL DEFAULT true,

    CONSTRAINT "RateNDFL_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "OwnerPPS" (
    "id" SERIAL NOT NULL,
    "inn" TEXT,
    "kpp" TEXT,
    "status" BOOLEAN DEFAULT false,
    "login" TEXT,
    "password" TEXT,
    "isAffiliate" BOOLEAN NOT NULL DEFAULT true,
    "name" TEXT,

    CONSTRAINT "OwnerPPS_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PPS" (
    "id" SERIAL NOT NULL,
    "status" BOOLEAN NOT NULL DEFAULT false,
    "name" TEXT NOT NULL DEFAULT 'Название ППС',
    "address" TEXT NOT NULL DEFAULT 'Полный адрес ППС',
    "ownerId" INTEGER,
    "balance" INTEGER DEFAULT 0,
    "balanceOnline" INTEGER DEFAULT 0,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "prefix" TEXT,
    "kpp" TEXT,
    "inn" TEXT,
    "kpo" TEXT,
    "numberingPKO" INTEGER NOT NULL DEFAULT 1,
    "numberingRKO" INTEGER NOT NULL DEFAULT 1,
    "maxDeposit" INTEGER NOT NULL DEFAULT 250000,
    "maxWithdrawal" INTEGER NOT NULL DEFAULT 900000,
    "uuid" TEXT,

    CONSTRAINT "PPS_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PPSShiftLink" (
    "id" SERIAL NOT NULL,
    "ppsId" INTEGER,
    "shiftId" INTEGER,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "PPSShiftLink_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PPSShift" (
    "id" SERIAL NOT NULL,
    "status" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "cashierId" INTEGER,
    "amount" INTEGER NOT NULL DEFAULT 0,
    "type" "ShiftType" NOT NULL DEFAULT 'checkout',
    "state" "ShiftState" NOT NULL DEFAULT 'open',
    "ppsId" INTEGER,
    "currentPpsBalance" INTEGER,

    CONSTRAINT "PPSShift_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Operation" (
    "id" SERIAL NOT NULL,
    "amount" INTEGER NOT NULL DEFAULT 0,
    "ppsId" INTEGER NOT NULL,
    "type" "OperationType",
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "cashierId" INTEGER,
    "method" "OperationMethod" DEFAULT 'user',
    "transactionId" INTEGER,
    "rs" BOOLEAN,
    "collectorId" TEXT,
    "shiftId" INTEGER,
    "numbering" INTEGER,
    "currentPpsBalance" INTEGER,
    "uuid" TEXT,

    CONSTRAINT "Operation_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "BettingMachine" (
    "id" TEXT NOT NULL,
    "certificate" TEXT,
    "name" TEXT DEFAULT 'Название ставкомата',
    "status" BOOLEAN NOT NULL DEFAULT false,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "ppsId" INTEGER NOT NULL,
    "ip" TEXT,
    "token" TEXT,
    "accountId" INTEGER,

    CONSTRAINT "BettingMachine_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ClubCard" (
    "id" TEXT NOT NULL,
    "value" TEXT,
    "status" BOOLEAN NOT NULL DEFAULT true,
    "key" TEXT NOT NULL,
    "userId" INTEGER,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "ClubCard_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PromoCode" (
    "id" SERIAL NOT NULL,
    "code" TEXT NOT NULL,
    "description" TEXT DEFAULT '',
    "userLimit" INTEGER DEFAULT 0,
    "balance" INTEGER DEFAULT 0,
    "startOfAction" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,
    "endOfAction" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,
    "status" BOOLEAN DEFAULT true,
    "type" "PromoCodeType" DEFAULT 'other',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "freebetId" TEXT,

    CONSTRAINT "PromoCode_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PromoCodeAccount" (
    "id" SERIAL NOT NULL,
    "accountId" INTEGER NOT NULL,
    "promocodeId" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "PromoCodeAccount_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "FreeBet" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "type" "FreeBetType" NOT NULL DEFAULT 'bonus',
    "status" BOOLEAN NOT NULL DEFAULT false,
    "startOfAction" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,
    "endOfAction" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,
    "autoRefill" BOOLEAN DEFAULT true,
    "balance" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "FreeBet_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "FreeBetName" (
    "freeBetId" TEXT NOT NULL,
    "ru" TEXT NOT NULL DEFAULT 'FreeBetNameRu',
    "en" TEXT NOT NULL DEFAULT 'FreeBetNameEn',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL
);

-- CreateTable
CREATE TABLE "FreeBetDescription" (
    "freeBetId" TEXT NOT NULL,
    "ru" TEXT NOT NULL DEFAULT 'FreeBetDescriptionRu',
    "en" TEXT NOT NULL DEFAULT 'FreeBetDescriptionEn',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL
);

-- CreateTable
CREATE TABLE "FreeBetTerms" (
    "id" TEXT NOT NULL,
    "status" BOOLEAN NOT NULL DEFAULT false,
    "prioritet" INTEGER DEFAULT 1,
    "freeBetId" TEXT,
    "type" "FreeBetTermsType" NOT NULL,
    "minDeposit" INTEGER DEFAULT 1000,
    "maxDeposit" INTEGER DEFAULT 10000,
    "place" "FreeBetPlaceBet",
    "amount" INTEGER DEFAULT 0,
    "minOdds" DOUBLE PRECISION,
    "maxOdds" DOUBLE PRECISION,
    "minAmount" INTEGER,
    "maxAmount" INTEGER,
    "betTermType" "FreeBetBet",
    "kind" "FreeBetKindBet",
    "betMin" DOUBLE PRECISION DEFAULT 3,
    "betMax" DOUBLE PRECISION DEFAULT 5,
    "betType" "FreeBetBet",
    "betCrushing" BOOLEAN DEFAULT false,
    "betPlace" "FreeBetPlaceBet",
    "betKind" "FreeBetKindBet",
    "dayExecute" INTEGER DEFAULT 3,
    "dayUsed" INTEGER NOT NULL DEFAULT 1,
    "balance" BOOLEAN NOT NULL DEFAULT false,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "FreeBetTerms_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "FreeBetAccount" (
    "id" SERIAL NOT NULL,
    "accountId" INTEGER NOT NULL,
    "state" BOOLEAN NOT NULL DEFAULT false,
    "close" BOOLEAN NOT NULL DEFAULT false,
    "freeBetId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "FreeBetAccount_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "FreeBetUserTerms" (
    "id" SERIAL NOT NULL,
    "freeBetAccountId" INTEGER NOT NULL,
    "state" BOOLEAN NOT NULL DEFAULT false,
    "close" BOOLEAN NOT NULL DEFAULT false,
    "termId" TEXT NOT NULL,
    "used" BOOLEAN NOT NULL DEFAULT false,
    "startUsed" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,
    "endUsed" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,
    "endExecute" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "FreeBetUserTerms_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Admin_login_key" ON "Admin"("login");

-- CreateIndex
CREATE UNIQUE INDEX "User_phoneNumber_key" ON "User"("phoneNumber");

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");

-- CreateIndex
CREATE UNIQUE INDEX "Account_userId_type_key" ON "Account"("userId", "type");

-- CreateIndex
CREATE UNIQUE INDEX "Token_token_key" ON "Token"("token");

-- CreateIndex
CREATE UNIQUE INDEX "Token_accountId_type_key" ON "Token"("accountId", "type");

-- CreateIndex
CREATE UNIQUE INDEX "Collector_login_key" ON "Collector"("login");

-- CreateIndex
CREATE UNIQUE INDEX "Collector_token_key" ON "Collector"("token");

-- CreateIndex
CREATE UNIQUE INDEX "CollectorPPS_collectorId_ppsId_key" ON "CollectorPPS"("collectorId", "ppsId");

-- CreateIndex
CREATE UNIQUE INDEX "Setting_userId_key" ON "Setting"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "Code_userId_key" ON "Code"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "Transaction_requestId_key" ON "Transaction"("requestId");

-- CreateIndex
CREATE UNIQUE INDEX "Transaction_freeBetId_key" ON "Transaction"("freeBetId");

-- CreateIndex
CREATE UNIQUE INDEX "Transaction_uuid_key" ON "Transaction"("uuid");

-- CreateIndex
CREATE UNIQUE INDEX "Document_userId_type_key" ON "Document"("userId", "type");

-- CreateIndex
CREATE UNIQUE INDEX "Pari_hash_key" ON "Pari"("hash");

-- CreateIndex
CREATE UNIQUE INDEX "Pari_winHash_key" ON "Pari"("winHash");

-- CreateIndex
CREATE UNIQUE INDEX "Pari_freeBetId_key" ON "Pari"("freeBetId");

-- CreateIndex
CREATE UNIQUE INDEX "OwnerPPS_login_key" ON "OwnerPPS"("login");

-- CreateIndex
CREATE UNIQUE INDEX "PPS_kpp_key" ON "PPS"("kpp");

-- CreateIndex
CREATE UNIQUE INDEX "PPS_uuid_key" ON "PPS"("uuid");

-- CreateIndex
CREATE UNIQUE INDEX "PPSShiftLink_ppsId_key" ON "PPSShiftLink"("ppsId");

-- CreateIndex
CREATE UNIQUE INDEX "PPSShiftLink_shiftId_key" ON "PPSShiftLink"("shiftId");

-- CreateIndex
CREATE UNIQUE INDEX "PPSShift_id_status_key" ON "PPSShift"("id", "status");

-- CreateIndex
CREATE UNIQUE INDEX "Operation_transactionId_key" ON "Operation"("transactionId");

-- CreateIndex
CREATE UNIQUE INDEX "Operation_uuid_key" ON "Operation"("uuid");

-- CreateIndex
CREATE UNIQUE INDEX "BettingMachine_accountId_key" ON "BettingMachine"("accountId");

-- CreateIndex
CREATE UNIQUE INDEX "ClubCard_key_key" ON "ClubCard"("key");

-- CreateIndex
CREATE UNIQUE INDEX "ClubCard_userId_key" ON "ClubCard"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "PromoCode_code_key" ON "PromoCode"("code");

-- CreateIndex
CREATE UNIQUE INDEX "PromoCodeAccount_accountId_promocodeId_key" ON "PromoCodeAccount"("accountId", "promocodeId");

-- CreateIndex
CREATE UNIQUE INDEX "FreeBetName_freeBetId_key" ON "FreeBetName"("freeBetId");

-- CreateIndex
CREATE UNIQUE INDEX "FreeBetDescription_freeBetId_key" ON "FreeBetDescription"("freeBetId");

-- CreateIndex
CREATE UNIQUE INDEX "FreeBetAccount_accountId_freeBetId_key" ON "FreeBetAccount"("accountId", "freeBetId");

-- AddForeignKey
ALTER TABLE "Admin" ADD CONSTRAINT "Admin_ppsId_fkey" FOREIGN KEY ("ppsId") REFERENCES "PPS"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Admin" ADD CONSTRAINT "Admin_ownerId_fkey" FOREIGN KEY ("ownerId") REFERENCES "Admin"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Account" ADD CONSTRAINT "Account_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Token" ADD CONSTRAINT "Token_accountId_fkey" FOREIGN KEY ("accountId") REFERENCES "Account"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PdlCategory" ADD CONSTRAINT "PdlCategory_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PdlRelative" ADD CONSTRAINT "PdlRelative_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BonusOperation" ADD CONSTRAINT "BonusOperation_accountId_fkey" FOREIGN KEY ("accountId") REFERENCES "Account"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Collation" ADD CONSTRAINT "Collation_cashierId_fkey" FOREIGN KEY ("cashierId") REFERENCES "Admin"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Collation" ADD CONSTRAINT "Collation_ppsId_fkey" FOREIGN KEY ("ppsId") REFERENCES "PPS"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CollectorPPS" ADD CONSTRAINT "CollectorPPS_collectorId_fkey" FOREIGN KEY ("collectorId") REFERENCES "Collector"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CollectorPPS" ADD CONSTRAINT "CollectorPPS_ppsId_fkey" FOREIGN KEY ("ppsId") REFERENCES "PPS"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Setting" ADD CONSTRAINT "Setting_userId_fkey" FOREIGN KEY ("userId") REFERENCES "Account"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Code" ADD CONSTRAINT "Code_userId_fkey" FOREIGN KEY ("userId") REFERENCES "Account"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Transaction" ADD CONSTRAINT "Transaction_ppsId_fkey" FOREIGN KEY ("ppsId") REFERENCES "PPS"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Transaction" ADD CONSTRAINT "Transaction_userId_fkey" FOREIGN KEY ("userId") REFERENCES "Account"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Transaction" ADD CONSTRAINT "Transaction_freeBetId_fkey" FOREIGN KEY ("freeBetId") REFERENCES "FreeBetUserTerms"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Erai" ADD CONSTRAINT "Erai_transactionId_fkey" FOREIGN KEY ("transactionId") REFERENCES "Transaction"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Erai" ADD CONSTRAINT "Erai_reportId_fkey" FOREIGN KEY ("reportId") REFERENCES "EraiReport"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Document" ADD CONSTRAINT "Document_userId_fkey" FOREIGN KEY ("userId") REFERENCES "Account"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Pari" ADD CONSTRAINT "Pari_userId_fkey" FOREIGN KEY ("userId") REFERENCES "Account"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Pari" ADD CONSTRAINT "Pari_bettingId_fkey" FOREIGN KEY ("bettingId") REFERENCES "BettingMachine"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Pari" ADD CONSTRAINT "Pari_freeBetId_fkey" FOREIGN KEY ("freeBetId") REFERENCES "FreeBetUserTerms"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Ticket" ADD CONSTRAINT "Ticket_supportId_fkey" FOREIGN KEY ("supportId") REFERENCES "Admin"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Ticket" ADD CONSTRAINT "Ticket_pariId_fkey" FOREIGN KEY ("pariId") REFERENCES "Pari"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Ticket" ADD CONSTRAINT "Ticket_transactionId_fkey" FOREIGN KEY ("transactionId") REFERENCES "Transaction"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Ticket" ADD CONSTRAINT "Ticket_userId_fkey" FOREIGN KEY ("userId") REFERENCES "Account"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TicketMessages" ADD CONSTRAINT "TicketMessages_ticketId_fkey" FOREIGN KEY ("ticketId") REFERENCES "Ticket"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TicketMessages" ADD CONSTRAINT "TicketMessages_supportId_fkey" FOREIGN KEY ("supportId") REFERENCES "Admin"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TicketMessages" ADD CONSTRAINT "TicketMessages_userId_fkey" FOREIGN KEY ("userId") REFERENCES "Account"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "MessageFile" ADD CONSTRAINT "MessageFile_messageId_fkey" FOREIGN KEY ("messageId") REFERENCES "TicketMessages"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PPS" ADD CONSTRAINT "PPS_ownerId_fkey" FOREIGN KEY ("ownerId") REFERENCES "OwnerPPS"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PPSShiftLink" ADD CONSTRAINT "PPSShiftLink_ppsId_fkey" FOREIGN KEY ("ppsId") REFERENCES "PPS"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PPSShiftLink" ADD CONSTRAINT "PPSShiftLink_shiftId_fkey" FOREIGN KEY ("shiftId") REFERENCES "PPSShift"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PPSShift" ADD CONSTRAINT "PPSShift_cashierId_fkey" FOREIGN KEY ("cashierId") REFERENCES "Admin"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PPSShift" ADD CONSTRAINT "PPSShift_ppsId_fkey" FOREIGN KEY ("ppsId") REFERENCES "PPS"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Operation" ADD CONSTRAINT "Operation_ppsId_fkey" FOREIGN KEY ("ppsId") REFERENCES "PPS"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Operation" ADD CONSTRAINT "Operation_cashierId_fkey" FOREIGN KEY ("cashierId") REFERENCES "Admin"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Operation" ADD CONSTRAINT "Operation_transactionId_fkey" FOREIGN KEY ("transactionId") REFERENCES "Transaction"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Operation" ADD CONSTRAINT "Operation_collectorId_fkey" FOREIGN KEY ("collectorId") REFERENCES "Collector"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Operation" ADD CONSTRAINT "Operation_shiftId_fkey" FOREIGN KEY ("shiftId") REFERENCES "PPSShift"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BettingMachine" ADD CONSTRAINT "BettingMachine_ppsId_fkey" FOREIGN KEY ("ppsId") REFERENCES "PPS"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BettingMachine" ADD CONSTRAINT "BettingMachine_accountId_fkey" FOREIGN KEY ("accountId") REFERENCES "Account"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ClubCard" ADD CONSTRAINT "ClubCard_userId_fkey" FOREIGN KEY ("userId") REFERENCES "Account"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PromoCode" ADD CONSTRAINT "PromoCode_freebetId_fkey" FOREIGN KEY ("freebetId") REFERENCES "FreeBet"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PromoCodeAccount" ADD CONSTRAINT "PromoCodeAccount_accountId_fkey" FOREIGN KEY ("accountId") REFERENCES "Account"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PromoCodeAccount" ADD CONSTRAINT "PromoCodeAccount_promocodeId_fkey" FOREIGN KEY ("promocodeId") REFERENCES "PromoCode"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "FreeBetName" ADD CONSTRAINT "FreeBetName_freeBetId_fkey" FOREIGN KEY ("freeBetId") REFERENCES "FreeBet"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "FreeBetDescription" ADD CONSTRAINT "FreeBetDescription_freeBetId_fkey" FOREIGN KEY ("freeBetId") REFERENCES "FreeBet"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "FreeBetTerms" ADD CONSTRAINT "FreeBetTerms_freeBetId_fkey" FOREIGN KEY ("freeBetId") REFERENCES "FreeBet"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "FreeBetAccount" ADD CONSTRAINT "FreeBetAccount_accountId_fkey" FOREIGN KEY ("accountId") REFERENCES "Account"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "FreeBetAccount" ADD CONSTRAINT "FreeBetAccount_freeBetId_fkey" FOREIGN KEY ("freeBetId") REFERENCES "FreeBet"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "FreeBetUserTerms" ADD CONSTRAINT "FreeBetUserTerms_freeBetAccountId_fkey" FOREIGN KEY ("freeBetAccountId") REFERENCES "FreeBetAccount"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "FreeBetUserTerms" ADD CONSTRAINT "FreeBetUserTerms_termId_fkey" FOREIGN KEY ("termId") REFERENCES "FreeBetTerms"("id") ON DELETE CASCADE ON UPDATE CASCADE;
