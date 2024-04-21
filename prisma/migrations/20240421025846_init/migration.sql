-- CreateTable
CREATE TABLE `User` (
    `id` VARCHAR(191) NOT NULL,
    `email` VARCHAR(191) NOT NULL,
    `phone` VARCHAR(191) NOT NULL,
    `cpf` VARCHAR(191) NOT NULL,
    `password` VARCHAR(191) NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `birth` VARCHAR(191) NOT NULL,
    `gender` ENUM('male', 'female', 'other', 'undefined') NOT NULL,
    `address_id` INTEGER NOT NULL,
    `profile_picture_id` VARCHAR(191) NULL,

    UNIQUE INDEX `User_email_key`(`email`),
    UNIQUE INDEX `User_phone_key`(`phone`),
    UNIQUE INDEX `User_cpf_key`(`cpf`),
    UNIQUE INDEX `User_address_id_key`(`address_id`),
    UNIQUE INDEX `User_profile_picture_id_key`(`profile_picture_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Address` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `user_id` VARCHAR(191) NULL,
    `street` VARCHAR(191) NOT NULL,
    `number` VARCHAR(191) NOT NULL,
    `district` VARCHAR(191) NOT NULL,
    `complement` VARCHAR(191) NULL,
    `city` VARCHAR(191) NOT NULL,
    `uf` VARCHAR(191) NOT NULL,
    `postcode` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Pet` (
    `id` VARCHAR(191) NOT NULL,
    `user_id` VARCHAR(191) NULL,
    `name` VARCHAR(191) NOT NULL,
    `species` VARCHAR(191) NULL,
    `breed` VARCHAR(191) NULL,
    `birth` VARCHAR(191) NULL,
    `weight` VARCHAR(191) NULL,
    `sex` ENUM('male', 'female', 'undefined') NULL,
    `color` VARCHAR(191) NULL,
    `emergency_contact` VARCHAR(191) NULL,
    `profile_picture_id` VARCHAR(191) NULL,
    `type` ENUM('exotic', 'domestic', 'rural') NULL,

    UNIQUE INDEX `Pet_profile_picture_id_key`(`profile_picture_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Media` (
    `id` VARCHAR(191) NOT NULL,
    `url` VARCHAR(191) NOT NULL,
    `type` ENUM('video', 'image') NOT NULL,
    `position` INTEGER NOT NULL DEFAULT 1,
    `width` INTEGER NOT NULL,
    `height` INTEGER NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Behavior` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(191) NOT NULL,
    `description` TEXT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Diet` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(191) NOT NULL,
    `quantity` VARCHAR(191) NULL,
    `interval` VARCHAR(191) NULL,
    `notes` TEXT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Provider` (
    `id` VARCHAR(191) NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `document` VARCHAR(191) NOT NULL,
    `type` ENUM('autonomous', 'business') NOT NULL,
    `address_id` INTEGER NOT NULL,
    `pet_type` ENUM('exotic', 'domestic', 'rural') NOT NULL,
    `profile_picture_id` VARCHAR(191) NULL,

    UNIQUE INDEX `Provider_profile_picture_id_key`(`profile_picture_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `BusinessHours` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Service` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `type` ENUM('medical', 'esthetics', 'lodging', 'walking', 'healthcare', 'breeding', 'transport', 'homecare') NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Schedule` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `pet_id` VARCHAR(191) NOT NULL,
    `provider_id` VARCHAR(191) NOT NULL,
    `datetime` VARCHAR(191) NOT NULL,
    `service_id` INTEGER NOT NULL,
    `recurrent` BOOLEAN NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `_PetToProvider` (
    `A` VARCHAR(191) NOT NULL,
    `B` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `_PetToProvider_AB_unique`(`A`, `B`),
    INDEX `_PetToProvider_B_index`(`B`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `_pet-gallery` (
    `A` VARCHAR(191) NOT NULL,
    `B` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `_pet-gallery_AB_unique`(`A`, `B`),
    INDEX `_pet-gallery_B_index`(`B`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `_provider-gallery` (
    `A` VARCHAR(191) NOT NULL,
    `B` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `_provider-gallery_AB_unique`(`A`, `B`),
    INDEX `_provider-gallery_B_index`(`B`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `_BehaviorToPet` (
    `A` INTEGER NOT NULL,
    `B` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `_BehaviorToPet_AB_unique`(`A`, `B`),
    INDEX `_BehaviorToPet_B_index`(`B`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `_diet_preferred` (
    `A` INTEGER NOT NULL,
    `B` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `_diet_preferred_AB_unique`(`A`, `B`),
    INDEX `_diet_preferred_B_index`(`B`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `_diet_restriction` (
    `A` INTEGER NOT NULL,
    `B` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `_diet_restriction_AB_unique`(`A`, `B`),
    INDEX `_diet_restriction_B_index`(`B`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `_ProviderToService` (
    `A` VARCHAR(191) NOT NULL,
    `B` INTEGER NOT NULL,

    UNIQUE INDEX `_ProviderToService_AB_unique`(`A`, `B`),
    INDEX `_ProviderToService_B_index`(`B`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `_BusinessHoursToProvider` (
    `A` INTEGER NOT NULL,
    `B` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `_BusinessHoursToProvider_AB_unique`(`A`, `B`),
    INDEX `_BusinessHoursToProvider_B_index`(`B`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `User` ADD CONSTRAINT `User_address_id_fkey` FOREIGN KEY (`address_id`) REFERENCES `Address`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `User` ADD CONSTRAINT `User_profile_picture_id_fkey` FOREIGN KEY (`profile_picture_id`) REFERENCES `Media`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Pet` ADD CONSTRAINT `Pet_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `User`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Pet` ADD CONSTRAINT `Pet_profile_picture_id_fkey` FOREIGN KEY (`profile_picture_id`) REFERENCES `Media`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Provider` ADD CONSTRAINT `Provider_address_id_fkey` FOREIGN KEY (`address_id`) REFERENCES `Address`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Provider` ADD CONSTRAINT `Provider_profile_picture_id_fkey` FOREIGN KEY (`profile_picture_id`) REFERENCES `Media`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Schedule` ADD CONSTRAINT `Schedule_pet_id_fkey` FOREIGN KEY (`pet_id`) REFERENCES `Pet`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Schedule` ADD CONSTRAINT `Schedule_provider_id_fkey` FOREIGN KEY (`provider_id`) REFERENCES `Provider`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Schedule` ADD CONSTRAINT `Schedule_service_id_fkey` FOREIGN KEY (`service_id`) REFERENCES `Service`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `_PetToProvider` ADD CONSTRAINT `_PetToProvider_A_fkey` FOREIGN KEY (`A`) REFERENCES `Pet`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `_PetToProvider` ADD CONSTRAINT `_PetToProvider_B_fkey` FOREIGN KEY (`B`) REFERENCES `Provider`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `_pet-gallery` ADD CONSTRAINT `_pet-gallery_A_fkey` FOREIGN KEY (`A`) REFERENCES `Media`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `_pet-gallery` ADD CONSTRAINT `_pet-gallery_B_fkey` FOREIGN KEY (`B`) REFERENCES `Pet`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `_provider-gallery` ADD CONSTRAINT `_provider-gallery_A_fkey` FOREIGN KEY (`A`) REFERENCES `Media`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `_provider-gallery` ADD CONSTRAINT `_provider-gallery_B_fkey` FOREIGN KEY (`B`) REFERENCES `Provider`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `_BehaviorToPet` ADD CONSTRAINT `_BehaviorToPet_A_fkey` FOREIGN KEY (`A`) REFERENCES `Behavior`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `_BehaviorToPet` ADD CONSTRAINT `_BehaviorToPet_B_fkey` FOREIGN KEY (`B`) REFERENCES `Pet`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `_diet_preferred` ADD CONSTRAINT `_diet_preferred_A_fkey` FOREIGN KEY (`A`) REFERENCES `Diet`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `_diet_preferred` ADD CONSTRAINT `_diet_preferred_B_fkey` FOREIGN KEY (`B`) REFERENCES `Pet`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `_diet_restriction` ADD CONSTRAINT `_diet_restriction_A_fkey` FOREIGN KEY (`A`) REFERENCES `Diet`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `_diet_restriction` ADD CONSTRAINT `_diet_restriction_B_fkey` FOREIGN KEY (`B`) REFERENCES `Pet`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `_ProviderToService` ADD CONSTRAINT `_ProviderToService_A_fkey` FOREIGN KEY (`A`) REFERENCES `Provider`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `_ProviderToService` ADD CONSTRAINT `_ProviderToService_B_fkey` FOREIGN KEY (`B`) REFERENCES `Service`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `_BusinessHoursToProvider` ADD CONSTRAINT `_BusinessHoursToProvider_A_fkey` FOREIGN KEY (`A`) REFERENCES `BusinessHours`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `_BusinessHoursToProvider` ADD CONSTRAINT `_BusinessHoursToProvider_B_fkey` FOREIGN KEY (`B`) REFERENCES `Provider`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;
