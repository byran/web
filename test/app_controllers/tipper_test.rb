require_relative 'app_controller_test_base'

class TipperControllerTest < AppControllerTestBase

  def self.hex_prefix
    '25E83A'
  end

  # - - - - - - - - - - - - - - - - - - - - - -

  test '3D4',
  'traffic_light_tip' do
    in_kata(:stateless) {
      as_avatar {
        2.times {
          run_tests
        }
      }
    }
    get '/tipper/traffic_light_tip', params: {
      'format'  => 'js',
      'id'      => kata.id,
      'avatar'  => avatar.name,
      'was_tag' => 0,
      'now_tag' => 1
    }
    assert_response :success
  end

end
