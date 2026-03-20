# Seeded Data Reference

Data inserted automatically on first startup (skipped if collections/tables already have data).

---

## PostgreSQL

```json
{
  "doctors": [
    {
      "DocId": "11111111-1111-1111-1111-111111111111",
      "Name": "Dr. Alice Carter",
      "Email": "alice.carter@example.com"
    },
    {
      "DocId": "22222222-2222-2222-2222-222222222222",
      "Name": "Dr. Ben Ortiz",
      "Email": "ben.ortiz@example.com"
    }
  ],
  "patients": [
    {
      "PatId": "aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa",
      "Name": "John Doe",
      "Email": "john.doe@example.com"
    },
    {
      "PatId": "bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb",
      "Name": "Jane Smith",
      "Email": "jane.smith@example.com"
    }
  ],
  "appointments": [
    {
      "AppointmentId": "cccccccc-cccc-cccc-cccc-cccccccccccc",
      "DocId": "11111111-1111-1111-1111-111111111111",
      "PatId": "aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa",
      "AppointmentDate": "2026-01-15",
      "AppointmentTime": "09:00",
      "AppointmentStatus": "Confirmed"
    },
    {
      "AppointmentId": "dddddddd-dddd-dddd-dddd-dddddddddddd",
      "DocId": "22222222-2222-2222-2222-222222222222",
      "PatId": "bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb",
      "AppointmentDate": "2026-01-16",
      "AppointmentTime": "10:30",
      "AppointmentStatus": "Completed"
    }
  ]
}
```

---

## MongoDB

All documents share `AppointmentId: "cccccccc-cccc-cccc-cccc-cccccccccccc"` (Dr. Alice Carter + John Doe).

```json
{
  "Consultations": [
    {
      "ConsultationId": "cccccccc-cccc-cccc-cccc-cccccccccccc",
      "AppointmentId": "cccccccc-cccc-cccc-cccc-cccccccccccc",
      "DoctorId": "11111111-1111-1111-1111-111111111111",
      "DoctorName": "Dr. Alice Carter",
      "PatientId": "aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa",
      "PatientName": "John Doe",
      "PatientEmail": "john.doe@example.com",
      "Status": "completed"
    }
  ],
  "RawTranscripts": [
    {
      "AppointmentId": "cccccccc-cccc-cccc-cccc-cccccccccccc",
      "DoctorId": "11111111-1111-1111-1111-111111111111",
      "DoctorName": "Dr. Alice Carter",
      "PatientId": "aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa",
      "PatientName": "John Doe",
      "Transcription": "Dr. Carter: Good morning, John. What brings you in today? John: Morning, Doctor. I've been feeling really unwell for about two weeks now. I have a persistent cough that won't go away, I'm running a fever most evenings — around 38.5 degrees — and I've lost about 3 kilograms without trying. I'm also exhausted all the time even when I sleep enough. Dr. Carter: I see. Any night sweats or chest pain? John: Yes, I wake up drenched most nights. No chest pain but I do get short of breath when I climb stairs. Dr. Carter: Based on what you're describing — the prolonged cough, fever, weight loss, night sweats, and fatigue — I want to run blood tests and a chest X-ray to rule out a respiratory infection or something more serious. In the meantime rest and stay hydrated. I'm prescribing a broad-spectrum antibiotic to start and we'll adjust once we have the results. Please avoid contact with vulnerable people until we know more."
    }
  ],
  "Summaries": [
    {
      "AppointmentId": "cccccccc-cccc-cccc-cccc-cccccccccccc",
      "DoctorId": "11111111-1111-1111-1111-111111111111",
      "DoctorName": "Dr. Alice Carter",
      "PatientId": "aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa",
      "PatientName": "John Doe",
      "Output": "John Doe, a 34-year-old male, presented with a two-week history of persistent productive cough, evening fever peaking at 38.5°C, significant unintentional weight loss of 3 kg, profuse night sweats, generalised fatigue, and exertional dyspnoea. Dr. Carter noted the constellation of symptoms is suggestive of a serious respiratory or systemic illness requiring further investigation. Blood tests and a chest X-ray were ordered to rule out tuberculosis, atypical pneumonia, or other pathology. A broad-spectrum antibiotic was prescribed empirically pending results, and the patient was advised to rest, maintain hydration, and avoid close contact with immunocompromised individuals.",
      "Type": "summary",
      "Status": "approved"
    }
  ],
  "DoctorNotes": [
    {
      "AppointmentId": "cccccccc-cccc-cccc-cccc-cccccccccccc",
      "DoctorId": "11111111-1111-1111-1111-111111111111",
      "DoctorName": "Dr. Alice Carter",
      "PatientId": "aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa",
      "PatientName": "John Doe",
      "Symptoms": "Persistent productive cough (2 weeks), evening fever (38.5°C), unintentional weight loss (3 kg), profuse night sweats, generalised fatigue, exertional dyspnoea",
      "Diagnosis": "Suspected atypical pneumonia or pulmonary tuberculosis — pending investigations",
      "Description": "34-year-old male presenting with a two-week history of constitutional and respiratory symptoms. Clinical picture warrants urgent chest X-ray and full blood count to exclude serious pulmonary pathology.",
      "AdvicePrescription": "1. Chest X-ray and full blood count requested urgently. 2. Amoxicillin-clavulanate 875/125 mg twice daily for 7 days (empirical). 3. Rest and increase fluid intake. 4. Avoid contact with immunocompromised individuals. 5. Return immediately if symptoms worsen or new symptoms develop.",
      "PdfUrl": "",
      "Status": "approved"
    }
  ]
}
```

---

## Quick Test IDs

Use these to hit GET endpoints immediately after startup:

- `appointmentId` = `cccccccc-cccc-cccc-cccc-cccccccccccc`
- `consultationId` = `cccccccc-cccc-cccc-cccc-cccccccccccc`
