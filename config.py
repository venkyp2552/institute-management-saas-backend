import os
from dotenv import load_dotenv

load_dotenv()

class Settings:
    RAZORPAY_KEY_ID = os.getenv("RAZORPAY_KEY_ID")
    RAZORPAY_KEY_SECRET = os.getenv("RAZORPAY_KEY_SECRET")
    FRONTEND_URL = os.getenv("FRONTEND_URL", "http://localhost:3000")
    SUPABASE_URL = os.getenv("SUPABASE_URL")
    SUPABASE_SERVICE_KEY = os.getenv("SUPABASE_SERVICE_KEY")
    MOCK_PAYMENTS = os.getenv("MOCK_PAYMENTS", "false").lower() == "true"

settings = Settings()
