-- =====================================================
-- RBAC MODULE - SQL MIGRATION
-- Step 1: Run this in phpMyAdmin on i_loan_management
-- =====================================================

-- 1. admin_users table mein role column update karo
--    (already hai, bas ENUM mein convert karo)
ALTER TABLE `admin_users`
  MODIFY COLUMN `role` ENUM('superadmin','admin','manager','qa') NOT NULL DEFAULT 'admin';

-- 2. Existing user ko superadmin banao
UPDATE `admin_users` SET `role` = 'superadmin' WHERE `id` = 1;

-- 3. Test users add karo (password: Test@1234)
INSERT INTO `admin_users` (`name`, `email`, `password`, `role`, `status`) VALUES
('Admin User',    'admin@iloan.com',    '$2b$10$YYgx8b2DGc5p68H9mroSZesDe6A7qcPLmfPaRVUS6Xc5HwsfsvfSy', 'admin',    'Active'),
('Manager User',  'manager@iloan.com',  '$2b$10$YYgx8b2DGc5p68H9mroSZesDe6A7qcPLmfPaRVUS6Xc5HwsfsvfSy', 'manager',  'Active'),
('QA User',       'qa@iloan.com',       '$2b$10$YYgx8b2DGc5p68H9mroSZesDe6A7qcPLmfPaRVUS6Xc5HwsfsvfSy', 'qa',       'Active');

-- 4. Role permissions table (kon sa role kaunsa module dekh sakta hai)
CREATE TABLE IF NOT EXISTS `role_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role` ENUM('superadmin','admin','manager','qa') NOT NULL,
  `module` varchar(50) NOT NULL,
  `can_view` tinyint(1) DEFAULT 1,
  `can_create` tinyint(1) DEFAULT 0,
  `can_edit` tinyint(1) DEFAULT 0,
  `can_delete` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `role_module` (`role`,`module`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 5. Default permissions set karo
-- SUPERADMIN: sab kuch
INSERT INTO `role_permissions` (`role`, `module`, `can_view`, `can_create`, `can_edit`, `can_delete`) VALUES
('superadmin', 'dashboard',    1,1,1,1),
('superadmin', 'enquiries',    1,1,1,1),
('superadmin', 'applications', 1,1,1,1),
('superadmin', 'documents',    1,1,1,1),
('superadmin', 'approval',     1,1,1,1),
('superadmin', 'customers',    1,1,1,1),
('superadmin', 'reports',      1,1,1,1),
('superadmin', 'settings',     1,1,1,1),
('superadmin', 'user_management', 1,1,1,1),

-- ADMIN: sab kuch except user_management delete
('admin', 'dashboard',    1,1,1,0),
('admin', 'enquiries',    1,1,1,1),
('admin', 'applications', 1,1,1,1),
('admin', 'documents',    1,1,1,1),
('admin', 'approval',     1,1,1,0),
('admin', 'customers',    1,1,1,0),
('admin', 'reports',      1,0,0,0),
('admin', 'settings',     1,1,1,0),
('admin', 'user_management', 0,0,0,0),

-- MANAGER: enquiries, applications, customers
('manager', 'dashboard',    1,0,0,0),
('manager', 'enquiries',    1,1,1,0),
('manager', 'applications', 1,1,1,0),
('manager', 'documents',    1,1,0,0),
('manager', 'approval',     1,0,0,0),
('manager', 'customers',    1,1,1,0),
('manager', 'reports',      1,0,0,0),
('manager', 'settings',     0,0,0,0),
('manager', 'user_management', 0,0,0,0),

-- QA: sirf documents aur reports (read only)
('qa', 'dashboard',    1,0,0,0),
('qa', 'enquiries',    0,0,0,0),
('qa', 'applications', 0,0,0,0),
('qa', 'documents',    1,0,0,0),
('qa', 'approval',     0,0,0,0),
('qa', 'customers',    0,0,0,0),
('qa', 'reports',      1,0,0,0),
('qa', 'settings',     0,0,0,0),
('qa', 'user_management', 0,0,0,0);

-- =====================================================
-- Done! Ab backend files add karo.
-- =====================================================
