class Admin::UserApprovalController < Admin::BaseController
  layout "admin"

  def dashboard
    response = Oj.load('{
    "success": true,
    "data": {
        "search_results": [
            {
                "id": 0,
                "uts": 1566395530,
                "payload": {
                    "user_id": "1000",
                    "video_id": "3"
                }
            }
        ],
        "users": {
            "1000": {
                "id": 1000,
                "user_name": "aman_barbaria",
                "name": "AMAN BARBARIA",
                "status": "ACTIVE",
                "uts": 1566395531,
                "ost_user_id": "c465dfa6-8ddc-410d-a998-d06c8bbbf0c4",
                "ost_token_holder_address": "",
                "ost_status": "CREATED",
                "profile_image_id": "16"
            }
        },
        "images": {
            "8": {
                "id": 8,
                "resolutions": {
                    "original": {
                        "url": "https://dbvoeb7t6hffk.cloudfront.net/d/ua/images/1002-84865392f3a27cd563ec5f8aa6b190fe-original.jpg",
                        "size": 100,
                        "height": 100,
                        "width": 100
                    }
                },
                "status": "NOT_RESIZED",
                "uts": 1566213993
            },
            "16": {
                "id": 16,
                "resolutions": {
                    "original": {
                        "url": "https://pbs.twimg.com/profile_images/1151817095241273344/8aiFaXn4.jpg"
                    }
                },
                "status": "NOT_RESIZED",
                "uts": 1566395529
            }
        },
        "videos": {
            "3": {
                "id": 3,
                "resolutions": {
                    "original": {
                        "url": "https://dbvoeb7t6hffk.cloudfront.net/d/ua/videos/1002-1b15e8b57ee88e55d46c88dd1a7063cd-original.mp4",
                        "size": 100,
                        "height": 100,
                        "width": 100
                    }
                },
                "status": "NOT_COMPRESSED",
                "poster_image_id": "8",
                "uts": 1566213993
            }
        },
        "meta": {
            "next_page_payload": null
        },
        "result_type": "search_results"
    }
}')

    response = HashWithIndifferentAccess.new(response)

    @search_response = response[:data]
  end

end
