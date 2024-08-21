import itertools
import math
import wave


FRAMERATE = 44100


def sound_wave(freq, num_secs):
    """
    Calculate the 8-bit unsigned integer PCM samples of a sin wave
    for a given freqency and number of seconds
    """
    for frame in range(round(num_secs * FRAMERATE)):
        time = frame / FRAMERATE  # current frame number / frame rate = time
        # A(t) = Asin(2 * PI * f * t + phase)
        amplitude = math.sin(2 * math.pi * freq * time)

        # add other octaves in the sine wave
        amplitude = (amplitude + math.sin(2 * math.pi * (freq / 2) * time)) / 2
        amplitude = (amplitude + math.sin(2 * math.pi * (freq / 4) * time)) / 2

        # shift the signed amplitude to unsigned and scale to 255 bits
        yield round((amplitude + 1) / 2 * 255)


def stereo_frames(left, right):
    return itertools.chain(*zip(left, right))


def write_sine(filename: str, freq_left: int, freq_right: int):
    with wave.open(filename, mode="wb") as f:
        f.setnchannels(2)
        f.setsampwidth(1)
        f.setframerate(FRAMERATE)
        f.writeframes(
            bytes(
                stereo_frames(sound_wave(freq_left, 2.5), sound_wave(freq_right, 2.5))
            )
        )


if __name__ == "__main__":
    write_sine("output.wav", 440, 480)
