import { useQuery } from '@tanstack/react-query'
import type { UseQueryOptions } from '@tanstack/react-query'
import type {
    BookingRequest,
    GetApiConsultationGetDoctorAppointmentsParams,
    GetApiSummaryGetSummaryParams,
    GetApiTranscriptGetTranscriptParams,
    PostApiSummaryGenerateSummaryParams,
    PostApiTranscriptGenerateTranscriptBody,
    PostApiTranscriptGenerateTranscriptParams,
    TranscriptEditRequest,
    PutApiTranscriptEditTranscriptParams,
    SummaryEditRequest,
    PutApiSummaryEditSumamryParams,
    PostApiPrescriptionGeneratePrescriptionParams,
    PrescriptionEditRequest,
    PutApiPrescriptionEditPrescriptionParams,
    PostApiPrescriptionApprovePrescriptionParams,
} from './model'
import { customFetch } from './customFetch'

const BASE = 'http://localhost:5001'

// ─── Consultation ─────────────────────────────────────────────────────────────

export const postApiConsultationStartConsultation = (body: BookingRequest, options?: RequestInit) =>
    customFetch<any>(`${BASE}/api/Consultation/StartConsultation`, {
        ...options,
        method: 'POST',
        headers: { 'Content-Type': 'application/json', ...options?.headers },
        body: JSON.stringify(body),
    })

export const deleteApiConsultationCompleteConsultation = (consultationId: string, options?: RequestInit) => {
    const qs = new URLSearchParams({ consultationId }).toString()
    return customFetch<any>(`${BASE}/api/Consultation/CompleteConsultation?${qs}`, {
        ...options,
        method: 'DELETE',
    })
}

export const getApiConsultationGetDoctorAppointments = (
    params?: GetApiConsultationGetDoctorAppointmentsParams,
    options?: RequestInit,
) => {
    const qs = new URLSearchParams(params as any).toString()
    return customFetch<any>(`${BASE}/api/Consultation/GetDoctorAppointments${qs ? `?${qs}` : ''}`, {
        ...options,
        method: 'GET',
    })
}

export const useGetApiConsultationGetDoctorAppointments = (
    params?: GetApiConsultationGetDoctorAppointmentsParams,
    options?: { query?: Partial<UseQueryOptions> },
) =>
    useQuery({
        queryKey: ['GetDoctorAppointments', params],
        queryFn: ({ signal }) => getApiConsultationGetDoctorAppointments(params, { signal }),
        ...options?.query,
    })

// ─── Transcript ───────────────────────────────────────────────────────────────

export const postApiTranscriptGenerateTranscript = (
    body: PostApiTranscriptGenerateTranscriptBody,
    params?: PostApiTranscriptGenerateTranscriptParams,
    options?: RequestInit,
) => {
    const formData = new FormData()
    if (body.audio) formData.append('audio', body.audio, 'audio.wav')
    const qs = new URLSearchParams(params as any).toString()
    return customFetch<any>(`${BASE}/api/Transcript/GenerateTranscript${qs ? `?${qs}` : ''}`, {
        ...options,
        method: 'POST',
        body: formData,
    })
}

export const getApiTranscriptGetTranscript = (
    params?: GetApiTranscriptGetTranscriptParams,
    options?: RequestInit,
) => {
    const qs = new URLSearchParams(params as any).toString()
    return customFetch<any>(`${BASE}/api/Transcript/GetTranscript${qs ? `?${qs}` : ''}`, {
        ...options,
        method: 'GET',
    })
}

export const useGetApiTranscriptGetTranscript = (
    params?: GetApiTranscriptGetTranscriptParams,
    options?: { query?: Partial<UseQueryOptions> },
) =>
    useQuery({
        queryKey: ['GetTranscript', params],
        queryFn: ({ signal }) => getApiTranscriptGetTranscript(params, { signal }),
        ...options?.query,
    })

// ─── Summary ──────────────────────────────────────────────────────────────────

export const postApiSummaryGenerateSummary = (
    params?: PostApiSummaryGenerateSummaryParams,
    options?: RequestInit,
) => {
    const qs = new URLSearchParams(params as any).toString()
    return customFetch<any>(`${BASE}/api/Summary/GenerateSummary${qs ? `?${qs}` : ''}`, {
        ...options,
        method: 'POST',
    })
}

export const getApiSummaryGetSummary = (
    params?: GetApiSummaryGetSummaryParams,
    options?: RequestInit,
) => {
    const qs = new URLSearchParams(params as any).toString()
    return customFetch<any>(`${BASE}/api/Summary/GetSummary${qs ? `?${qs}` : ''}`, {
        ...options,
        method: 'GET',
    })
}

export const useGetApiSummaryGetSummary = (
    params?: GetApiSummaryGetSummaryParams,
    options?: { query?: Partial<UseQueryOptions> },
) =>
    useQuery({
        queryKey: ['GetSummary', params],
        queryFn: ({ signal }) => getApiSummaryGetSummary(params, { signal }),
        ...options?.query,
    })

export const putApiTranscriptEditTranscript = (
    body: TranscriptEditRequest,
    params?: PutApiTranscriptEditTranscriptParams,
    options?: RequestInit,
) => {
    const qs = new URLSearchParams(params as any).toString()
    return customFetch<any>(`${BASE}/api/Transcript/EditTranscript${qs ? `?${qs}` : ''}`, {
        ...options,
        method: 'PUT',
        headers: { 'Content-Type': 'application/json', ...options?.headers },
        body: JSON.stringify(body),
    })
}

// NOTE: route has a typo in the backend — it is literally "EditSumamry"
export const putApiSummaryEditSumamry = (
    body: SummaryEditRequest,
    params?: PutApiSummaryEditSumamryParams,
    options?: RequestInit,
) => {
    const qs = new URLSearchParams(params as any).toString()
    return customFetch<any>(`${BASE}/api/Summary/EditSumamry${qs ? `?${qs}` : ''}`, {
        ...options,
        method: 'PUT',
        headers: { 'Content-Type': 'application/json', ...options?.headers },
        body: JSON.stringify(body),
    })
}

// ─── Prescription ─────────────────────────────────────────────────────────────

export const postApiPrescriptionGeneratePrescription = (
    params?: PostApiPrescriptionGeneratePrescriptionParams,
    options?: RequestInit,
) => {
    const qs = new URLSearchParams(params as any).toString()
    return customFetch<any>(`${BASE}/api/Prescription/GeneratePrescription${qs ? `?${qs}` : ''}`, {
        ...options,
        method: 'POST',
    })
}

export const putApiPrescriptionEditPrescription = (
    body: PrescriptionEditRequest,
    params?: PutApiPrescriptionEditPrescriptionParams,
    options?: RequestInit,
) => {
    const qs = new URLSearchParams(params as any).toString()
    return customFetch<any>(`${BASE}/api/Prescription/EditPrescription${qs ? `?${qs}` : ''}`, {
        ...options,
        method: 'PUT',
        headers: { 'Content-Type': 'application/json', ...options?.headers },
        body: JSON.stringify(body),
    })
}

export const postApiPrescriptionApprovePrescription = (
    params?: PostApiPrescriptionApprovePrescriptionParams,
    options?: RequestInit,
) => {
    const qs = new URLSearchParams(params as any).toString()
    return customFetch<any>(`${BASE}/api/Prescription/ApprovePrescription${qs ? `?${qs}` : ''}`, {
        ...options,
        method: 'POST',
    })
}
