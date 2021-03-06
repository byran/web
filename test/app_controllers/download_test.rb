require_relative 'app_controller_test_base'

class DownloadControllerTest < AppControllerTestBase

  def self.hex_prefix
    'C446C5'
  end

  def hex_setup
    set_storer_class('StorerService')
  end

  #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # download: positive tests
  #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  test '561',
  'download of empty dojo with no avatars',
  'untars to same as original folder' do
    in_kata(:stateless) {}
    download
    assert_downloaded
  end

  #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  test '1B1',
  'download of dojo with one avatar and one traffic-light',
  'untars to same as original folder' do
    in_kata(:stateful) {
      as_avatar {
        kata_edit
        change_file('hiker.rb', '...')
        run_tests
      }
    }
    download
    assert_downloaded
  end

  #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  test 'E9B',
  'download of dojo with five animals and five traffic-lights',
  'untars to same as original folder' do
    in_kata(:stateful) {
      5.times {
        as_avatar {
          kata_edit
          change_file('hiker.rb', '/*comment*/')
          run_tests
          change_file('hiker.rb', '...')
          run_tests
        }
      }
    }
    download
    assert_downloaded
  end

  #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # download: negative tests
  #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  test '0EF',
  'download with empty id raises' do
    @id = ''
    error = assert_raises(StandardError) {
      download
    }
    assert error.message.end_with? 'invalid kata_id', error.message
  end

  #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  test '849',
  'download with bad id raises' do
    @id = 'XX'
    error = assert_raises(StandardError) {
      download
    }
    assert error.message.end_with? 'invalid kata_id', error.message
  end

  #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # download_tag: positive test
  #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  test 'A45',
  'download_tag' do
    in_kata(:stateful) {
      as_avatar {
        @tag = 0
        download_tag
        assert_downloaded_tag
        kata_edit
        change_file('hiker.rb', '...')
        run_tests
        @tag = 1
        download_tag
        assert_downloaded_tag
      }
    }
  end

  #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # download_tag: negative test
  #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  test '6F7',
  'download_tag with empty kata_id raises' do
    @id = ''
    @avatar_name = 'salmon'
    @tag = 0
    error = assert_raises(StandardError) {
      download_tag
    }
    assert error.message.end_with?'invalid kata_id', error.message
  end

  private # = = = = = = = = = = = = = = = = = = =

  def download
    get '/download', params: { 'id' => @id }
  end

  def download_tag
    params = { 'id' => @id, 'avatar' => @avatar_name, 'tag' => @tag }
    get '/download_tag', params:params
  end

  def assert_downloaded
    assert_response :success
  end

  def assert_downloaded_tag
    assert_response :success
  end

end
