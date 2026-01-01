# Be sure to restart your server when you modify this file.

# Define an application-wide content security policy.
# See the Securing Rails Applications Guide for more information:
# https://guides.rubyonrails.org/security.html#content-security-policy-header

Rails.application.config.content_security_policy do |policy|
  policy.default_src :self
  policy.base_uri    :self
  policy.object_src  :none

  policy.script_src  :self, :https, :unsafe_inline
  policy.style_src   :self, :https, :unsafe_inline

  policy.img_src     :self, :data, :blob, :https
  policy.font_src    :self, :https, :data

  policy.connect_src :self, :https, "ws://127.0.0.1:3000"
end

Rails.application.config.content_security_policy_report_only = false