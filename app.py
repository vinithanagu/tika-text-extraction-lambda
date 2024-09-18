import base64
import requests

TIKA_URL = "http://localhost:9998/tika"

def is_tika_running():
    try:
        reposne = requests.get(TIKA_URL)
        return reposne.status_code == 200
    except requests.ConnectionError:
        return False

def handler(event, context):
    if not is_tika_running():
        return {
                'statusCode': 500,
                'body': 'Tika server is not running'
        }
    
    file_content = base64.b64decode(event['body'])
    file_path = '/tmp/uploaded_file'

    with open(file_path, 'wb') as file:
        file.write(file_content)

    # Send the file to the Tika server using multipart/form-data
    with open(file_path, 'rb') as f:
        files = {'file': ('uploaded_file', f, 'application/octet-stream')}
        headers = {
            'Accept': 'text/plain'
        }
        response = requests.post(f'{TIKA_URL}form', files=files, headers=headers)

   return {
        'statusCode': reposne.status_code,
        'body': response.text
    }
