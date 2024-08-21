import math
import wave


FRAMERATE = 44100


def sound_wave(freq1, freq2, num_secs):
    """
    Calculate the 8-bit unsigned integer PCM samples of a sin wave
    for a given freqency and number of seconds
    """
    for frame in range(round(num_secs * FRAMERATE)):
        time = frame / FRAMERATE  # current frame number / frame rate = time
        # A(t) = Asin(2 * PI * f * t + phase)
        amplitude1 = math.sin(2 * math.pi * freq1 * time)
        amplitude2 = math.sin(2 * math.pi * freq2 * time)

        # add other octaves in the sine wave
        amplitude = max(-1, min(amplitude1 + amplitude2, 1))

        # shift the signed amplitude to unsigned and scale to 255 bits
        yield round((amplitude + 1) / 2 * 255)


def write_sine(filename: str, freq1: int, freq2: int):
    with wave.open(filename, mode="wb") as f:
        f.setnchannels(1)
        f.setsampwidth(1)
        f.setframerate(FRAMERATE)
        f.writeframes(bytes(sound_wave(freq1, freq2, 2.5)))


if __name__ == "__main__":
    write_sine("output.wav", 440, 441)
