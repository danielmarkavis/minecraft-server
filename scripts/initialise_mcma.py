import os
import subprocess

password = os.environ['MCMA_PASSWORD']
print("pass is " + password)
#subprocess.check_call(['./MCMA2_Linux_x86_64', '-setpass', password, '-configonly'], shell=True)
subprocess.check_call(['./MCMA2_Linux_x86_64', '-configonly'], shell=True)
