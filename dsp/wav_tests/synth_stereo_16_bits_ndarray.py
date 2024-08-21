import wave
import numpy as np


FRAMERATE = 44100


def sound_wave(freq, num_secs):
    """
    Calculate the 8-bit unsigned integer PCM samples of a sin wave
    for a given freqency and number of seconds
    """
    time = np.arange(0, num_secs, 1 / FRAMERATE)
    amplitude = np.sin(2 * np.pi * freq * time)
    return np.clip(
        np.round(amplitude * 32768),
        -32768,
        32767,
    ).astype("<h")


def stereo_frames(left, right):
    return np.dstack((left, right)).flatten()


def write_sine(filename: str, freq_left: int, freq_right: int):
    with wave.open(filename, mode="wb") as f:
        f.setnchannels(2)
        f.setsampwidth(2)
        f.setframerate(FRAMERATE)
        f.writeframes(
            bytes(
                stereo_frames(sound_wave(freq_left, 2.5), sound_wave(freq_right, 2.5))
            )
        )


if __name__ == "__main__":
    write_sine("output.wav", 440, 480)
