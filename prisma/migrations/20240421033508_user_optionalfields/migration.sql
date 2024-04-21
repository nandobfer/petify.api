-- AlterTable
ALTER TABLE `User` MODIFY `birth` VARCHAR(191) NULL,
    MODIFY `gender` ENUM('male', 'female', 'other', 'undefined') NULL,
    MODIFY `address_id` INTEGER NULL;
