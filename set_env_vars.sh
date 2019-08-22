# Note this secret has to be same for pepo-web & pepo-api in order to make CSRF work
# As FE uses staging ENV for local testing, this should be in sync with Staging API Secret
export PEPO_SECRET_KEY_BASE='fc06a409bf0a2fc2e8b316ceeb04e8675900f3176668d2a836494417e0164a966aefd701430390d3db685f87c224cbb48b332f8a5cf490fa7f034e063ff13a94'

# Cloudfront details
export PW_CLOUDFRONT_DOMAIN=''

# Company API details
export PW_ROOT_URL='http://developmentost.com:8080/'
export PW_PA_ROOT_URL='http://kit.developmentost.com:8080/'
export PW_PA_COOKIE_DOMAIN='kit.developmentost.com'

# Basic Auth credentials
export PW_BASIC_AUTH_USERNAME='ost'
export PW_BASIC_AUTH_PASSWORD='A$F^&n!@$ghf%7'

