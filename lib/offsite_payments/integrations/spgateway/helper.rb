require 'digest'

module OffsitePayments
  module Integrations
    module Spgateway
      class Helper < OffsitePayments::Helper

        CHECK_VALUE_FIELDS = %w(Amt MerchantID MerchantOrderNo TimeStamp Version)

        # 依照官方文件進行排序
        #
        # [x] 表示必填
        #
        # [x] 商店代號
        mapping :account, 'MerchantID' # active_merchant common field
        # [x] 回傳格式
        mapping :respond_type, 'RespondType'
        # [x] 檢查碼
        mapping :check_value, 'CheckValue'
        # [x] 時間戳記
        mapping :time_stamp, 'TimeStamp'
        # [x] 串接程式版本
        mapping :version, 'Version'
        # 語系
        mapping :lang_type, 'LangType'
        # [x] 商店訂單編號
        mapping :order, 'MerchantOrderNo' # active_merchant common field
        # [x] 訂單金額
        mapping :amount, 'Amt' # active_merchant common field
        # [x] 商品資訊
        mapping :item_desc, 'ItemDesc'
        # 交易限制秒數
        mapping :trade_limit, 'TradeLimit'
        # 繳費有效期限(適用於非即時交易)
        mapping :expire_date, 'ExpireDate'
        # 支付完成返回商店網址
        mapping :return_url, 'ReturnURL'
        # 支付通知網址
        mapping :notify_url, 'NotifyURL'
        # 商店取號網址
        mapping :customer_url, 'CustomerURL'
        # 支付取消返回商店網址
        mapping :client_back_url, 'ClientBackURL'
        # [x] 付款人電子信箱
        mapping :email, 'Email'
        # 付款人電子信箱是否開放修改
        mapping :email_odify, 'EmailModify'
        # [x] 智付通會員(是否需要登入)
        mapping :login_type, 'LoginType'
        # 商店備註
        mapping :order_comment, 'OrderComment'
        # 信用卡一次付清啟用
        mapping :credit, 'CREDIT'
        # 信用卡分期付款啟用
        mapping :inst_flag, 'InstFlag'
        # WEBATM 啟用
        mapping :web_atm, 'WEBATM'
        # ATM 轉帳啟用
        mapping :vacc, 'VACC'
        # 超商代碼繳費啟用
        mapping :cvs, 'CVS'
        # 條碼繳費啟用
        mapping :barcode, 'BARCODE'
        # 自訂支付啟用
        mapping :custom, 'CUSTOM'

        def initialize(order, account, options = {})
          super
          add_field 'MerchantID', ActiveMerchant::Billing::Integrations::Spgateway.merchant_id
        end

        def generate_check_value
          raw_data = CHECK_VALUE_FIELDS.sort.map{ |field| "#{field}=#{@fields[field]}" }.compact.join('&')
          raw_data = "HashKey=#{ActiveMerchant::Billing::Integrations::Spgateway.hash_key}&#{raw_data}&HashIV=#{ActiveMerchant::Billing::Integrations::Spgateway.hash_iv}"
          add_field 'CheckValue', Digest::SHA256.hexdigest(raw_data).upcase
        end
      end
    end
  end
end
